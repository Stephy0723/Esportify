# Esportify Backend

Esportify is a backend application designed to manage esports teams and user interactions. This project provides APIs for creating teams, managing users, and displaying a main page based on user preferences.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Contributing](#contributing)
- [License](#license)

## Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/esportify-backend.git
   ```
2. Navigate to the project directory:
   ```
   cd esportify-backend
   ```
3. Install the dependencies:
   ```
   npm install
   ```
4. Create a `.env` file in the root directory and add your database connection string and any other necessary environment variables.

## Usage

To start the server, run:
```
npm start
```
The server will run on `http://localhost:5000` (or the port specified in your `.env` file).

## API Endpoints

### User Routes
- `POST /api/users` - Register a new user.

### Team Routes
- `POST /api/teams` - Create a new team.
- `GET /api/teams` - Retrieve all teams.

### Main Page Route
- `GET /api/main` - Display the main page based on user selections.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or features.

## License

This project is licensed under the MIT License. See the LICENSE file for details.