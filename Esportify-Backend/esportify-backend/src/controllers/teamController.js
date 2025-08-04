class TeamController {
    constructor(TeamModel) {
        this.TeamModel = TeamModel;
    }

    async createTeam(req, res) {
        const { name, members } = req.body;

        if (!name || !members) {
            return res.status(400).json({ message: 'Name and members are required' });
        }

        try {
            const newTeam = new this.TeamModel({ name, members });
            await newTeam.save();
            return res.status(201).json(newTeam);
        } catch (error) {
            return res.status(500).json({ message: 'Error creating team', error });
        }
    }
}

module.exports = TeamController;