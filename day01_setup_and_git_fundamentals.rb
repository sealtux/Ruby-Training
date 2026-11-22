# frozen_string_literal: true

# Run: ruby day01_setup_and_git_fundamentals.rb

def command_available?(command)
  system(command, out: File::NULL, err: File::NULL)
end

def version(command)
  `#{command} 2>&1`.strip
end

puts "\nDay 1 — Setup & Git Fundamentals"
puts "=" * 36

tools = {
  "Ruby" => ["ruby -v", "Install Ruby through RVM or your preferred Ruby installer."],
  "Git" => ["git --version", "Install Git from https://git-scm.com/downloads."]
}

tools.each do |name, (command, help)|
  if command_available?(command)
    puts "✓ #{name}: #{version(command)}"
  else
    puts "✗ #{name} was not found. #{help}"
  end
end

puts "\nYour Git identity:"
name = `git config --global user.name 2>/dev/null`.strip
email = `git config --global user.email 2>/dev/null`.strip
puts "Name:  #{name.empty? ? 'Not configured' : name}"
puts "Email: #{email.empty? ? 'Not configured' : email}"

puts <<~GIT_GUIDE

  Practice these commands in your project folder:

    git status
    git add day01_setup_and_git_fundamentals.rb
    git commit -m "Add Day 1 setup exercise"
    git log --oneline

  Next steps:
  1. Create a repository on GitHub.
  2. Add the GitHub repository as the remote origin.
  3. Push your first commit.
GIT_GUIDE
