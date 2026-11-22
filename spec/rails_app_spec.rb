# Run each stage: TRAINING_DAY=9 bundle exec rspec spec/rails_app_spec.rb
require "tmpdir"
ENV["RAILS_ENV"] = "test"
ENV["TRAINING_DATABASE"] = File.join(Dir.mktmpdir("ojt-test-"), "test.sqlite3")
require_relative "../training_app/config/environment"
require_relative "../training_app/db/prepare"
require "rack/test"
require "nokogiri"

RSpec.describe "Day #{ENV.fetch('TRAINING_DAY', '6')} Rails app" do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def token
    Nokogiri::HTML(last_response.body).at_css('meta[name="csrf-token"]')["content"]
  end

  def submit(method, path, data = {})
    public_send(method, path, data.merge(authenticity_token: token))
  end

  before { header "Host", "localhost" }

  it "supports CRUD, validation, comments, and ownership at the relevant stage" do
    day = ENV.fetch("TRAINING_DAY", "6").to_i
    if day >= 9
      get "/"
      expect(last_response.status).to eq(302)
      get "/signup"
      expect(last_response.status).to eq(200)
      submit :post, "/signup", user: { email: "first@example.com", password: "long-password", password_confirmation: "long-password" }
      expect(last_response.status).to eq(302)
    end

    get "/tasks/new"
    expect(last_response.status).to eq(200)
    submit :post, "/tasks", task: { title: "" }
    expect(last_response.status).to eq(422)
    submit :post, "/tasks", task: { title: "Learn Ruby", description: "Practice", user_id: 999 }
    expect(last_response.status).to eq(302)
    task = Task.last
    expect(task.title).to eq("Learn Ruby")
    expect(task.user.email).to eq("first@example.com") if day >= 9
    get "/tasks/#{task.id}/edit"
    submit :patch, "/tasks/#{task.id}", task: { title: "Learn Rails", completed: "1" }
    expect(last_response.status).to eq(302)
    expect(task.reload.completed).to be true
    get "/tasks/#{task.id}"
    expect(last_response.body).to include("Learn Rails")

    if day >= 8
      submit :post, "/tasks/#{task.id}/comments", comment: { body: "" }
      expect(last_response.status).to eq(422)
      submit :post, "/tasks/#{task.id}/comments", comment: { body: "Great progress" }
      expect(last_response.status).to eq(302)
      expect(task.comments.count).to eq(1)
      get "/tasks/#{task.id}"
    end

    if day >= 9
      submit :delete, "/logout"
      get "/login"
      submit :post, "/login", email: "first@example.com", password: "incorrect"
      expect(last_response.status).to eq(422)
      submit :post, "/login", email: "first@example.com", password: "long-password"
      expect(last_response.status).to eq(302)
      get "/"
      submit :delete, "/logout"
      get "/signup"
      submit :post, "/signup", user: { email: "second@example.com", password: "long-password", password_confirmation: "long-password" }
      get "/"
      expect(last_response.body).not_to include("Learn Rails")
      csrf = token
      get "/tasks/#{task.id}"
      expect(last_response.status).to eq(404)
      patch "/tasks/#{task.id}", authenticity_token: csrf, task: { title: "Stolen" }
      expect(last_response.status).to eq(404)
      delete "/tasks/#{task.id}", authenticity_token: csrf
      expect(last_response.status).to eq(404)
      post "/tasks/#{task.id}/comments", authenticity_token: csrf, comment: { body: "Intrusion" }
      expect(last_response.status).to eq(404)
      delete "/tasks/#{task.id}/comments/#{task.comments.first.id}", authenticity_token: csrf
      expect(last_response.status).to eq(404)
      get "/"
      submit :delete, "/logout"
      get "/login"
      submit :post, "/login", email: "first@example.com", password: "long-password"
      get "/tasks/#{task.id}"
    end

    submit :delete, "/tasks/#{task.id}"
    expect(last_response.status).to eq(303)
    expect(Task.exists?(task.id)).to be false
    expect(Comment.where(task_id: task.id).count).to eq(0)
  end

  it "rejects form submissions without a CSRF token" do
    post(ENV.fetch("TRAINING_DAY", "6").to_i >= 9 ? "/login" : "/tasks", {})
    expect(last_response.status).to eq(422)
  end

  it "creates an event with nested guests on Day 10" do
    skip "Day 10 only" unless ENV.fetch("TRAINING_DAY", "6").to_i >= 10

    get "/signup"
    submit :post, "/signup", user: { email: "events@example.com", password: "long-password", password_confirmation: "long-password" }
    get "/events/new"
    expect(last_response.status).to eq(200)
    submit :post, "/events", event: {
      title: "Ruby meetup", location: "Community Hub", starts_at: "2030-02-10T18:00",
      guests_attributes: { "0" => { name: "Ana", email: "ana@example.com" } }
    }
    expect(last_response.status).to eq(302)
    event = Event.last
    expect(event.ends_at).to eq(event.starts_at + 2.hours)
    expect(event.guests.pluck(:email)).to eq(["ana@example.com"])
    get "/events/#{event.id}"
    expect(last_response.body).to include("Ruby meetup")
  end
end
