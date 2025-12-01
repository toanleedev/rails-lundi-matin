# Lundi Matin Test

A modern Rails 7 application.

## Features

✅ **Authentication** - Secure login with API token
✅ **Search Clients** - Filter by name and city
✅ **View Details** - See complete client information
✅ **Edit Records** - Update client data
✅ **Modern UI** - Clean, responsive interface with Slim templates
✅ **Error Handling** - Graceful error messages and validation

## Quick Start

### Prerequisites
- Ruby 2.7.7
- Rails 7.0.10
- SQLite3

### Installation

```bash
# 1. Install gems
bundle install

# 2. Create databases
rails db:create

# 3. Start server
rails server -b 0.0.0.0 -p 3000
```

### Usage

1. Open `http://localhost:3000`
2. Login with your Lundi Matin credentials
3. Search for clients by name or city
4. Click "View" to see details
5. Click "Edit" to update information

## Architecture

### Key Files

```
app/
├── controllers/
│   ├── clients_controller.rb    # Main CRUD controller
│   └── sessions_controller.rb   # Authentication
├── services/
│   ├── auth_service.rb          # API authentication
│   └── client_service.rb        # API client operations
└── views/
    ├── layouts/application.html.slim
    ├── clients/
    │   ├── index.html.slim      # Search & list
    │   ├── show.html.slim       # Details
    │   └── edit.html.slim       # Edit form
    └── sessions/
        └── new.html.slim        # Login
```

## API Integration

Uses Faraday HTTP client to communicate with:
`https://evaluation-technique-v9.lundimatin.biz/api`

### Endpoints

- `POST /auth` - Get authentication token
- `GET /clients` - Search clients
- `GET /clients/{id}` - Get client details
- `PUT /clients/{id}` - Update client

## Development

### Console

```bash
rails console
```

### Database

```bash
rails db:reset
rails db:seed
```

## Deployment

For production deployment:

1. Set environment variables
2. Use encrypted credentials
3. Configure Redis for sessions
4. Use HTTPS only
5. Set up proper error logging

## Troubleshooting

**Can't login?**
- Check username/password
- Verify API is accessible
- Check internet connection

**Client not found?**
- Try different search criteria
- Verify client ID exists

**Page not loading?**
- Check Rails server is running
- Clear browser cache
- Check console for errors

## Technologies

- **Rails 7.0.10** - Web framework
- **Ruby 2.7.7** - Programming language
- **Slim** - Template engine
- **Faraday** - HTTP client
- **SQLite3** - Database

## License

Internal project for Lundi Matin
