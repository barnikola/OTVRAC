const express = require('express');
const app = express();
const port = 3000;
const path = require('path');

const homeRoutes = require('./routes/home.routes');
const tableRoutes = require('./routes/table.routes');
const apiRouter = require('./api');
const client =require('./db');

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

app.get('/download/csv', async (req, res) => {
    try {
        const query = `
      COPY (
        SELECT igrac_id, tim_id,
          podaci->>'Naziv' AS Naziv,
          podaci->>'Drzava' AS Zemlja,
          podaci->>'Godina_osnutka' AS Godina_osnutka,
          podaci->>'Skracenica' AS Skracenica,
          podaci->>'Esport' AS Esport,
          podaci->>'Broj_trofeja' AS Broj_trofeja,
          podaci->>'Pobjede2023' AS Pobjede2023,
          podaci->>'Porazi2023' AS Porazi2023,
          podaci->>'Regija' AS Regija,
          podaci->>'Ukupna_zarada' AS Ukupna_zarada,
          jsonb_array_elements(podaci->'Igraci')->>'Ime' AS Ime,
          jsonb_array_elements(podaci->'Igraci')->>'Prezime' AS Prezime,
          jsonb_array_elements(podaci->'Igraci')->>'Nickname' AS Nickname,
          jsonb_array_elements(podaci->'Igraci')->>'Pozicija' AS Pozicija,
          jsonb_array_elements(podaci->'Igraci')->>'Godina_prikljucenja' AS Godina_prikljucenja
        FROM timovi_json t
      ) TO STDOUT WITH CSV HEADER;
    `;
        const csvStream = await client.query(query);

        res.header('Content-Type', 'text/csv');
        res.attachment('timoviIgraci.csv');
        csvStream.pipe(res);
    } catch (err) {
        console.error('Error generating CSV:', err);
        res.status(500).send('Error generating CSV');
    }
});

app.get('/download/json', async (req, res) => {
    try {
        const query = `
      SELECT json_build_object(
        'Naziv', podaci->>'Naziv',
        'Zemlja', podaci->>'Drzava',
        'Godina_osnutka', podaci->>'Godina_osnutka',
        'Skracenica', podaci->>'Skracenica',
        'Esport', podaci->>'Esport',
        'Broj_trofeja', podaci->>'Broj_trofeja', 
        'Pobjede2023', podaci->>'Pobjede2023',
        'Porazi2023', podaci->>'Porazi2023',
        'Regija', podaci->>'Regija',
        'Ukupna_zarada', podaci->>'Ukupna_zarada',
        'Igraci', json_agg(json_build_object(
                  'igrac_id', igrac->>'igrac_id'
            'Ime', igrac->>'Ime',
            'Prezime', igrac->>'Prezime',
            'Nickname', igrac->>'Nickname',
            'Pozicija', igrac->>'Pozicija',
            'Godina_prikljucenja', igrac->>'Godina_prikljucenja'
          ))
      ) AS timovi
      FROM timovi_json t
      JOIN LATERAL jsonb_array_elements(podaci->'Igraci') AS igrac ON true
      GROUP BY tim_id;
    `;

        const result = await client.query(query);
        const jsonData = JSON.stringify(result.rows, null, 2);

        res.header('Content-Type', 'application/json');
        res.attachment('timoviIgraci.json');
        res.send(jsonData);
    } catch (err) {
        console.error('Error generating JSON:', err);
        res.status(500).send('Error generating JSON');
    }
});

app.use('/', homeRoutes);
app.use('/', tableRoutes);
app.use('/timovi', tableRoutes);
app.use('/api', apiRouter);

app.listen(port, () => {
    console.log(`Server listening at http://localhost:${port}`);
});
