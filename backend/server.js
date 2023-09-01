const express = require('express');
const bodyParser = require('body-parser');
const hanoiService = require('./incode');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());

// Service to solve the Hanoi problem
app.get('/incode/hanoi', async (req, res) => {
    const { disks } = req.query;
    const result = await hanoiService.get('client/incode/hanoi', { disks: parseInt(disks) }, null);
    return res.status(200).json(result);
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
