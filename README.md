# MyQuote

MyQuote is a Rails MVC prototype for managing philosopher quotes with public browsing and administrative controls.

## Setup

1. Install dependencies:
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
- Public homepage and search limited to public quotes, including category browsing.
- Quotes belong to a philosopher and at least one category, with optional publication year and personal comment.
- Admin tools to promote/demote users, set status, and delete accounts.

## Known Limitations

- Internet access is required for `bundle install` to download gems (use an environment with Ruby and Bundler installed).
- No automated test suite is provided; acceptance is verified manually per the assignment brief.
