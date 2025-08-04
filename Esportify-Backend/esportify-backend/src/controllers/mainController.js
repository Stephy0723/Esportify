class MainController {
    async getMainPage(req, res) {
        try {
            // Logic to retrieve user preferences and related information
            const userId = req.user.id; // Assuming user ID is available in the request
            const userPreferences = await User.findById(userId).populate('preferences');

            // Render the main page with user-specific data
            res.status(200).json({
                message: 'Main page data retrieved successfully',
                data: userPreferences
            });
        } catch (error) {
            res.status(500).json({
                message: 'Error retrieving main page data',
                error: error.message
            });
        }
    }
}

module.exports = new MainController();