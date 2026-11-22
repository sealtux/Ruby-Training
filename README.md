# How to Run the OJT Exercises

This project contains runnable exercises for **Days 1–10**. Days 1–5 run in the terminal. Days 6–10 launch a Rails app that you open in your browser.

## 1. Open the project terminal

In VS Code, open **Terminal → New Terminal**, then enter:

```bash
cd ~/Documents/VSC/Ruby/Project1
```

Run all commands below from this folder. Copy only the command—not your terminal's username or `$` prompt.

## 2. Install dependencies if needed

Dependencies are already installed in this workspace. On a fresh setup, with Ruby and Bundler installed, run:

```bash
bundle install
```

This project has been tested with Ruby 3.4.6. Installing dependencies requires internet access.

## Day 1 — Setup & Git Fundamentals

```bash
ruby day01_setup_and_git_fundamentals.rb
```

- Checks whether Ruby and Git are available.
- Displays your configured Git name and email.
- Provides the Git commands to practice before making your first GitHub push.

## Day 2 — Ruby Basics

```bash
ruby day02_ruby_basics.rb
```

- Enter your name, then a whole-number score from **0 to 100**.
- The script displays your result; **60** is the passing score.
- Enter another score to continue, or type **`q`** to quit.

## Day 3 — Enumerables & Debugging

```bash
ruby day03_enumerable_and_debugging.rb
```

Displays the passing students and the class average, then exits automatically.

To look up a student and display debugging information:

```bash
ruby day03_enumerable_and_debugging.rb Ana --debug
```

You can replace `Ana` with `Ben`, `Carlo`, or `Dina`.

## Day 4 — Object-Oriented Ruby: Tic Tac Toe

```bash
ruby day04_object_oriented_ruby.rb
```

- Two players share the terminal: Player 1 uses **X**, and Player 2 uses **O**.
- Take turns entering an empty position from **1 to 9**, as shown on the board.
- The game ends after a win or draw. Type **`q`** to quit early.

## Day 5 — Advanced Ruby & RSpec

```bash
ruby day05_advanced_ruby_and_rspec.rb
```

Runs the shopping cart tests and exits automatically. A successful run ends with:

```text
6 examples, 0 failures
```

## Days 6–10 — How to Open the Rails Apps

1. Run **one** of the day commands below.
2. Wait for Puma to start and display **`Use Ctrl-C to stop`**.
3. Open the browser address printed beside **`Day N:`** in that terminal.
4. Keep the terminal running while using the app.
5. To stop it, click inside that terminal and press **Ctrl+C**.

The default address is `http://localhost:3000`. If that port is occupied, the launcher automatically chooses another available port, such as `http://localhost:3001`. **Use the address printed for the day you just started.**

Closing the browser tab does not stop the server. For the simplest workflow, stop the current server before switching days.

### Day 6 — Rails Setup & Basic CRUD

```bash
ruby day06_rails_setup_and_basics.rb
```

Open the printed address. Create a task, open its details, edit it, mark it complete through the edit form, or delete it using **Delete this task** on its details page.

### Day 7 — Controllers, Views & Tailwind

```bash
ruby day07_controllers_views_and_tailwind.rb
```

Open the printed address. This version adds the styled dashboard and forms, including the design inspired by your reference image. Tailwind compiles automatically when the launcher starts.

### Day 8 — Active Record & Associations

```bash
ruby day08_active_record_and_associations.rb
```

Open the printed address. Create or open a task, then use **Notes & comments** to add and delete comments linked to that task.

### Day 9 — Forms & Authentication

```bash
ruby day09_forms_and_authentication.rb
```

Open the printed address. Click **Sign up** and create an account with an email address and a password of at least **10 characters**. Enter the same password in the confirmation field.

After signing in, create and manage your private tasks and comments. The sign-out icon is in the top navigation.

### Day 10 — Advanced Forms & Final Project

```bash
ruby day10_advanced_forms_and_final_project.rb
```

Create an account, then open **Events** in the navigation. Plan an event, invite guests using the nested guest form, edit the details, and review the finished event page. Leaving the end time blank automatically creates a two-hour event.

## Saved Data and Supporting Files

Each Rails day has its own SQLite database, so tasks from Day 6 will not automatically appear in Day 7, 8, or 9. Records remain saved when you stop and restart the same day.

Only run the `day01_...rb` through `day10_...rb` entry points shown above. Files in `support/` and `training_app/` are loaded by those entry points; they are not separate exercises to launch. Images, CSS, and view templates are displayed by the app.

## Troubleshooting

### A specific port is already in use

Normally, the launcher handles this automatically. If you previously set `PORT`, remove that setting and restart:

```bash
unset PORT
ruby day09_forms_and_authentication.rb
```

To deliberately request a particular port instead:

```bash
PORT=3005 ruby day09_forms_and_authentication.rb
```

An explicitly requested port must be free; the launcher will explain if it is occupied.

### The browser shows the wrong day

Check the address printed in the terminal for the day you want. Another day may still be running on port 3000.

### The design looks old after a change

Stop the server with **Ctrl+C**, rerun the same day command, and refresh its browser page. If necessary, use **Ctrl+Shift+R** to refresh without cached files.

### Ruby says it cannot find a file

Return to the project folder using the `cd` command at the top of this guide, then copy the exact filename from the relevant day command.

### A required gem is missing

Run `bundle install` from the project folder, then retry your day command.

## Optional: Run the Automated Checks

Shopping cart tests:

```bash
bundle exec rspec spec/shopping_cart_spec.rb
```

Port selection and server startup tests:

```bash
bundle exec rspec spec/server_port_spec.rb spec/server_startup_spec.rb
```

Rails checks for each day, using temporary test databases:

```bash
TRAINING_DAY=6 bundle exec rspec spec/rails_app_spec.rb
TRAINING_DAY=7 bundle exec rspec spec/rails_app_spec.rb
TRAINING_DAY=8 bundle exec rspec spec/rails_app_spec.rb
TRAINING_DAY=9 bundle exec rspec spec/rails_app_spec.rb
TRAINING_DAY=10 bundle exec rspec spec/rails_app_spec.rb
```
