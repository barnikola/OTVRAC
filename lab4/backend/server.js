const express = require('express');
const app = express();
const port = 3000;
const path = require('path');

const fs = require('fs');

const homeRoutes = require('./routes/home.routes');
const tableRoutes = require('./routes/table.routes');
const apiRouter = require('./api');
const client =require('./db');

const { auth } = require('express-openid-connect');

const config = {
    authRequired: false,
    auth0Logout: true,
    secret: 'sikretZaOtvoreno',
    baseURL: 'http://localhost:3000',
    clientID: 'JC0SltRkH1XCh4pDVpkFeNYdVZQLeuj4',
    issuerBaseURL: 'https://dev-wxxc0an8odyv80dd.us.auth0.com'
};

app.use(auth(config));

// app.get('/auth-status', (req, res) => {
//     const isAuth = req.oidc.isAuthenticated();
//     res.json({ isAuth });
// });

// req.isAuthenticated is provided from the auth router
// app.get('/', (req, res) => {
//     res.send(req.oidc.isAuthenticated() ? 'Logged in' : 'Logged out');
// });

// app.get('/', (req, res) => {
//     res.sendFile(path.join(__dirname, '../frontend/index.html'), {
//         isAuth: req.oidc.isAuthenticated()
//     });
// });


app.get('/', (req, res) => {
    const isAuth = req.oidc.isAuthenticated(); // Assuming you're using something like Auth0 or oidc for authentication
    const data = fs.readFileSync(path.join(__dirname, '../frontend/index.html'), 'utf8');

    const modifiedHtml = data.replace(
        '</body>',
        `
        <script>
            const isAuth = ${JSON.stringify(isAuth)};
            window.onload = function() {
                const login = document.getElementById('loginHeader');
                const logout = document.getElementById('logoutHeader');
                
                if (isAuth) {
                    login.style.display = 'none';
                    logout.style.display = 'flex';
                } else {
                    login.style.display = 'flex';
                    logout.style.display = 'none';
                }
            }
        </script>
        </body>`
    );

    res.send(modifiedHtml);
});

app.set('view engine', 'html');
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, '../frontend')));
app.use(express.static(path.join(__dirname, '..')));

app.get('/data', async (req, res) => {
    try {
        const result = await client.query('SELECT * FROM public.novi_igraci_razdvojeni_simple');
        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error retrieving data');
    }
});


app.use('/', homeRoutes);
app.use('/', tableRoutes);
app.use('/timovi', tableRoutes);
app.use('/api', apiRouter);
const { requiresAuth } = require('express-openid-connect');

app.get('/profile', requiresAuth(), (req, res) => {
    res.send(JSON.stringify(req.oidc.user));
});

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});
