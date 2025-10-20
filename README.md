# MyQuote

MyQuote is a Rails MVC prototype for managing philosopher quotes with public browsing and administrative controls.

## Target Environment

The application is designed to run on the Azure Linux development environment (or an identical local setup) with the following specifications:

- Ubuntu 22.04 LTS
- Ruby 3.4.5 (other Ruby 3.x releases are supported)
- Rails 8.0.2.1
- SQLite 3.42.0
- Git 2.41.0
- VS Code for editing

Use a Ruby version manager such as `mise`, `rbenv`, or `asdf` to install Ruby 3.4.5 or a compatible Ruby 3.x release and ensure a recent Bundler is available before installing gems.

## Requirements

- Ruby 3.x (see `.ruby-version` for the current baseline)
- Rails ~> 8.0.2 (per the `Gemfile`)
- SQLite 3.42.0

## Setup

1. Install dependencies (regenerates `Gemfile.lock` on first run):
    ```bash
    bundle install
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
- Discover page with a top-level keyword search and a left-aligned category sidebar that uses compact filter cards and removable chips to stack multiple filters.
- Quotes belong to a philosopher and at least one category, with optional publication year and personal comment.
- Admin tools to promote/demote users, set status, and delete accounts.
- Opinionated dark theme spanning navigation, tables, and modals for comfortable nighttime browsing.

## Known Limitations

- Internet access is required for `bundle install` to download gems (use an environment with Ruby and Bundler installed).
- No automated test suite is provided; acceptance is verified manually per the assignment brief.
- `Gemfile.lock` is intentionally omitted so the bundle can be resolved on different Ruby 3.x toolchains without pinning a specific platform build.
