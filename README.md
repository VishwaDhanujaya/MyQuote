# MyQuote

MyQuote is a Rails MVC prototype for managing philosopher quotes with public browsing and administrative controls.

## Target Environment

The application is designed to run on the Azure Linux development environment (or an identical local setup) with the following specifications:

- Ubuntu 22.04 LTS
- Ruby 3.2.2 (patch-level compatible Ruby 3.2.x builds work as well)
- Rails 7.0.4
- SQLite 3.42.0
- Git 2.41.0
- VS Code for editing

Use a Ruby version manager such as `mise`, `rbenv`, or `asdf` to install Ruby 3.2.2 and ensure Bundler 2.4.x is available before installing gems.

## Requirements

- Ruby 3.2.x (see `.ruby-version`)
- Rails ~> 7.0.4 (per the `Gemfile`)
- SQLite 3.42.0

## Setup

1. Install dependencies (regenerates `Gemfile.lock` on first run):
    ```bash
    bundle _2.4.19_ install
    ```
2. Prepare the database (creates, migrates, seeds):
   ```bash
   bin/rails db:prepare
   bin/rails db:seed
   ```
3. Start the server:
   ```bash
   bin/rails server
   ```

## Default Accounts

| Role   | Name          | Email                 | Password |
|--------|---------------|-----------------------|----------|
| Admin  | John Jones    | admin@myquotes.com    | admin123 |
| User   | Vincent Brown | vinceb@myemail.com    | vince123 |

## Key Features

- Email/password authentication with account status enforcement (active, suspended, banned).
- Role-based access with standard users managing only their quotes and admins managing users.
- Public homepage and search limited to public quotes, including category browsing.
- Quotes belong to a philosopher and at least one category, with optional publication year and personal comment.
- Admin tools to promote/demote users, set status, and delete accounts.

## Known Limitations

- Internet access is required for `bundle install` to download gems (use an environment with Ruby and Bundler installed).
- No automated test suite is provided; acceptance is verified manually per the assignment brief.
- `Gemfile.lock` is intentionally omitted so the bundle can be resolved on a Ruby 3.2.x toolchain that matches the required Azure Linux environment.
