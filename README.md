# Arsellis Management System (AMS)

Management System for Arsellis Landscape and Design - A comprehensive solution for managing all facets of a landscaping business.

## Overview

This application helps Arsellis Landscape and Design manage:
- **Employee Management** - Track employee information, roles, and contact details
- **Plant/Materials Stock** - (Coming Soon) Inventory management for plants and materials
- **Project Organization** - (Coming Soon) Project tracking and management
- **Vehicles** - (Coming Soon) Vehicle fleet management
- **Tools & Equipment** - (Coming Soon) Expensive tool tracking
- **Record Keeping** - (Coming Soon) Business records and documentation

## Getting Started

### Prerequisites

- Ruby 3.2.3
- SQLite3
- Bundler

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/tylermorrissey/ams.git
   cd ams
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Setup the database:
   ```bash
   rails db:migrate
   ```

4. Start the server:
   ```bash
   rails server
   ```

5. Visit http://localhost:3000 in your browser

## Project Structure

- `app/controllers/` - Application controllers
  - `home_controller.rb` - Homepage controller
  - `employees_controller.rb` - Employee management controller (example CRUD)
- `app/models/` - Application models
  - `employee.rb` - Employee model (example)
- `app/views/` - Application views
  - `layouts/application.html.erb` - Main layout template
  - `home/` - Homepage views
  - `employees/` - Employee management views
- `config/` - Application configuration
  - `routes.rb` - Route definitions
  - `database.yml` - Database configuration
- `db/migrate/` - Database migrations

## Development

This is a boilerplate application with an example Employee management module. Additional modules can be built following the same pattern:

1. Create a model in `app/models/`
2. Create a migration in `db/migrate/`
3. Create a controller in `app/controllers/`
4. Create views in `app/views/`
5. Add routes in `config/routes.rb`

## License

This project is proprietary software for Arsellis Landscape and Design.
