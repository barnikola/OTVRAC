const express = require('express');
const router = express.Router();
const path = require('path');
const client = require("./db");
//https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
router.get('/all', async (req, res) => {
    try {
        const result = await client.query('SELECT * FROM public.novi_igraci_razdvojeni_simple');

        const customJSON = result.rows.reduce((acc, row) => {
            const team = acc.find(t => t.Naziv === row.naziv);
            const player = {
                id: row.igrac_id,
                Ime: row.ime,
                Prezime: row.prezime,
                Nickname: row.nickname,
                Pozicija: row.pozicija,
                Godina_prikljucenja: row.godina_prikljucenja
            };
            if (team) {
                team.Igraci.push(player);
            } else {
                acc.push({
                    Naziv: row.naziv,
                    Zemlja: row.drzava,
                    Godina_osnutka: row.godina_osnutka,
                    Skracenica: row.skracenica,
                    Esport: row.esport,
                    Broj_trofeja: row.broj_trofeja,
                    Pobjede2023: row.pobjede2023,
                    Porazi2023: row.porazi2023,
                    Regija: row.regija,
                    Ukupna_zarada: row.ukupna_zarada,
                    Igraci: [player]
                });
            }
            return acc;
        }, []);

        res.json(customJSON);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error retrieving data');
    }
});

router.get('/igraci/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const result = await client.query(
            'SELECT * FROM public.novi_igraci_razdvojeni_simple WHERE igrac_id = $1',
            [id]
        );

        if (result.rows.length > 0) {
            res.status(200).json({
                status: "success",
                data: result.rows,
                message: `Player with id ${id} retrieved successfully.`,
            });
        } else {
            res.status(404).json({
                status: "error",
                message: `Player with id ${id} not found.`,
            });
        }
    } catch (err) {
        console.error("Error retrieving player data:", err.message);
        res.status(500).json({
            status: "error",
            message: "An internal server error occurred while retrieving player data.",
        });
    }
});

router.post("/igraci", async (req, res) => {
    const {
        naziv,
        skracenica,
        godina_osnutka,
        esport,
        broj_trofeja,
        drzava,
        pobjede2023,
        porazi2023,
        regija,
        ukupna_zarada,
        ime,
        prezime,
        nickname,
        pozicija,
        godina_prikljucenja,
    } = req.body;

    try {
        await client.query("BEGIN");

        const teamResult = await client.query(
            "SELECT tim_id FROM tim WHERE naziv = $1 AND skracenica = $2",
            [naziv, skracenica]
        );

        let timId;
        if (teamResult.rows.length > 0) {
            timId = teamResult.rows[0].tim_id;
        } else {
            const maxTimIdResult = await client.query("SELECT MAX(tim_id) AS max_id FROM tim");
            const maxTimId = maxTimIdResult.rows[0].max_id || 0;
            timId = maxTimId + 1;

            await client.query(
                `INSERT INTO tim (tim_id, naziv, skracenica, godina_osnutka, esport, broj_trofeja, drzava, pobjede2023, porazi2023, regija, ukupna_zarada)
                 VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)`,
                [
                    timId,
                    naziv,
                    skracenica,
                    godina_osnutka,
                    esport,
                    broj_trofeja,
                    drzava,
                    pobjede2023,
                    porazi2023,
                    regija,
                    ukupna_zarada,
                ]
            );
        }

        const punoIme = `${ime} ${prezime}`;

        const playerResult = await client.query(
            "SELECT igrac_id FROM igraci WHERE puno_ime = $1 AND nickname = $2 AND pozicija = $3 AND tim_id = $4",
            [punoIme, nickname, pozicija, timId]
        );

        let igracId;
        if (playerResult.rows.length > 0) {
            throw new Error("Player already exists in the database.");
        } else {
            const maxIgracIdResult = await client.query("SELECT MAX(igrac_id) AS max_id FROM igraci");
            const maxIgracId = maxIgracIdResult.rows[0].max_id || 0;
            igracId = maxIgracId + 1;

            await client.query(
                `INSERT INTO igraci (igrac_id, puno_ime, nickname, pozicija, godina_prikljucenja, tim_id)
                 VALUES ($1, $2, $3, $4, $5, $6)`,
                [igracId, punoIme, nickname, pozicija, godina_prikljucenja, timId]
            );
        }

        await client.query("COMMIT");

        res.status(201).json({ message: "Player and team successfully added!" });
    } catch (error) {
        await client.query("ROLLBACK");
        console.error(error);
        res.status(500).json({ error: error.message });
    }
});

router.put("/igraci/:igrac_id", async (req, res) => {
    const { igrac_id } = req.params;
    const { nickname, pozicija, godina_prikljucenja, tim_id } = req.body;

    try {
        const playerExists = await client.query(
            "SELECT * FROM igraci WHERE igrac_id = $1",
            [igrac_id]
        );

        if (playerExists.rows.length === 0) {
            return res.status(404).json({ error: "Player not found." });
        }

        const updateQuery = `
            UPDATE igraci
            SET 
                nickname = COALESCE($1, null,  nickname),
                pozicija = COALESCE($2,null, pozicija),
                godina_prikljucenja = COALESCE($3,null, godina_prikljucenja),
                tim_id = COALESCE($4,null, tim_id)
            WHERE igrac_id = $5
        `;

        await client.query(updateQuery, [
            nickname,
            pozicija,
            godina_prikljucenja,
            tim_id,
            igrac_id,
        ]);

        res.status(200).json({ message: "Player updated successfully!" });
    } catch (error) {
        console.error("Error updating player:", error.message);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

router.delete("/igraci/:igrac_id", async (req, res) => {
    const { igrac_id } = req.params;
    try {
        const deleteQuery = ' DELETE from igraci where igrac_id = $1';
        await client.query(deleteQuery, [igrac_id]);
        res.status(200).json({ message: "Player deleted successfully!" });

    } catch (error) {
        console.error("Error deleting player:", error.message);
        res.status(500).json({ error: "Internal Server Error" });
    }
})

router.get("/timovi/top-prihodi/:limit", async (req, res) => {
    const { limit } = req.params;

    try {
        const result = await client.query(
            `SELECT tim_id, naziv, skracenica, regija, ukupna_zarada
             FROM tim
             ORDER BY ukupna_zarada DESC
             LIMIT $1`,
            [limit]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: "No teams found." });
        }

        res.status(200).json(result.rows);
    } catch (error) {
        console.error("Error fetching top revenue teams:", error.message);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

router.get("/timovi/:tim_id/igraci", async (req, res) => {
    const { tim_id } = req.params;

    try {
        const result = await client.query(
            "SELECT * FROM igraci WHERE tim_id = $1",
            [tim_id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: "No players found for the specified team." });
        }

        res.status(200).json(result.rows);
    } catch (error) {
        console.error("Error fetching players for team:", error.message);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

router.get("/timovi/regija/:regija", async (req, res) => {
    const { regija } = req.params;

    try {
        const result = await client.query(
            "SELECT * FROM tim WHERE regija = $1",
            [regija]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ message: "No teams found for the specified region." });
        }

        res.status(200).json(result.rows);
    } catch (error) {
        console.error("Error fetching teams by region:", error.message);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

module.exports = router;