const express = require('express');
const hbs = require('hbs');
const fs = require('fs');

var app = express();

app.listen(3000, () => {
    console.log('Server is up on port 3000');
});

app.set('view engine', 'hbs');
app.use(express.static(__dirname + '/public'));


// app.use is how you register middleware
app.use((req, res, next) => {
    var now = new Date().toString();
    var log = `${now}: ${req.method} ${req.url}`;

    console.log(log);
    fs.appendFile('server.log', log + '\n', (err) => {
        if (err) {
            console.log('Unable to append to server.log');
        }
    });

    //next used when it's done! The app just continues when calls next()
    next();
});

app.get('/', (req, res) => {
    // res.send('<h1>Hello Express!</h1>');
    res.send({
        name: 'Ana',
        likes: [
            'Cats',
            'iOS'
        ]
    });
});

app.get('/about', (req, res) => {
    res.render('about.hbs', {
        pageTitle: 'About Page',
        currentYear: new Date().getFullYear()
    });
});

app.get('/bad', (req, res) => {
    res.send({
        errorMessage: 'Unable to handle request'
    });
});
