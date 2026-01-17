<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
    String error = request.getParameter("error");
    String idVolParam = request.getParameter("idVol");
    String dateParam = request.getParameter("date");
    
    // Extract date only (YYYY-MM-DD format for input type="date")
    String dateOnly = "";
    if (dateParam != null && !dateParam.isEmpty()) {
        // If date contains time, extract only the date part
        if (dateParam.contains(" ")) {
            dateOnly = dateParam.split(" ")[0];
        } else if (dateParam.contains("T")) {
            dateOnly = dateParam.split("T")[0];
        } else {
            dateOnly = dateParam;
        }
        // Ensure format is YYYY-MM-DD (take first 10 characters)
        if (dateOnly.length() > 10) {
            dateOnly = dateOnly.substring(0, 10);
        }
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Réservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= contextPath %>/css/modern-theme.css">
    <style>
        .siege-grid {
            display: grid;
            grid-template-columns: repeat(6, 1fr);
            gap: 8px;
            margin: 20px auto;
            padding: 30px;
            background: white;
            border: 2px solid var(--primary-violet);
            border-radius: 8px;
            max-width: 600px;
            position: relative;
        }
        
        /* Allée au milieu (entre colonnes 3 et 4) */
        .siege-grid::after {
            content: '';
            position: absolute;
            left: 50%;
            top: 30px;
            bottom: 30px;
            width: 20px;
            margin-left: -10px;
            background: linear-gradient(90deg, transparent 40%, #e5e7eb 40%, #e5e7eb 60%, transparent 60%);
            pointer-events: none;
        }
        
        .siege-row {
            display: grid;
            grid-column: 1 / -1;
            grid-template-columns: repeat(6, 1fr);
            gap: 8px;
            align-items: center;
            position: relative;
        }
        
        .row-label {
            position: absolute;
            left: -40px;
            font-weight: 600;
            color: var(--primary-blue);
            width: 30px;
            text-align: center;
        }
        
        .siege-btn {
            padding: 10px;
            border: 2px solid var(--primary-violet);
            background: white;
            cursor: pointer;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
            color: var(--primary-blue);
            min-height: 45px;
            font-size: 0.75em;
            aspect-ratio: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }
        
        .siege-btn .numero {
            font-weight: 700;
            font-size: 0.9em;
        }
        
        .siege-btn .classe-badge {
            font-size: 0.6em;
            margin-top: 2px;
            padding: 1px 3px;
            border-radius: 2px;
            background: rgba(99, 102, 241, 0.1);
            color: var(--primary-violet);
        }
        
        .siege-btn:hover:not(:disabled) {
            background: #e0e7ff;
            border-color: var(--primary-violet);
            transform: scale(1.1);
            box-shadow: 0 4px 6px rgba(99, 102, 241, 0.2);
        }
        
        .siege-btn.selected {
            background: var(--primary-violet);
            color: white;
            border-color: var(--violet-dark);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.3);
        }
        
        .siege-btn.selected .classe-badge {
            background: rgba(255, 255, 255, 0.3);
            color: white;
        }
        
        .siege-btn:disabled {
            background: #f3f4f6;
            cursor: not-allowed;
            color: #9ca3af;
            border-color: #d1d5db;
        }
        
        .siege-legend {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f9fafb;
            border-radius: 6px;
            flex-wrap: wrap;
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9em;
        }
        
        .legend-box {
            width: 30px;
            height: 30px;
            border-radius: 4px;
            border: 2px solid var(--primary-violet);
        }
        
        .legend-box.available {
            background: white;
            border-color: var(--primary-violet);
        }
        
        .legend-box.occupied {
            background: #f3f4f6;
            border-color: #d1d5db;
        }
        
        .legend-box.selected {
            background: var(--primary-violet);
            border-color: var(--violet-dark);
        }
        
        .cockpit {
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
            color: var(--primary-blue);
            font-size: 0.9em;
        }
        
        .seat-navigation {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 20px;
            margin-top: 15px;
        }
        
        .nav-btn {
            background: var(--primary-violet);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }
        
        .nav-btn:hover:not(:disabled) {
            background: var(--violet-dark);
            transform: scale(1.05);
        }
        
        .nav-btn:disabled {
            background: #d1d5db;
            cursor: not-allowed;
            opacity: 0.5;
        }
        
        .page-info {
            font-weight: 600;
            color: var(--primary-blue);
        }
        
        .step-section {
            background: var(--gray-lighter);
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            border-left: 4px solid var(--primary-violet);
        }
        
        .step-section h3 {
            color: var(--primary-blue);
            margin-bottom: 15px;
            font-size: 1.1em;
        }
    </style>
</head>
<body>
    <jsp:include page="/jsp/components/sidebar.jsp" />
    <div class="main-content">
        <header class="header">
            <h1>Effectuer une Réservation</h1>
        </header>
        <div class="container">
            <div class="content-wrapper">
                <% if (error != null) { %>
                    <div class="alert alert-danger">Erreur: <%= error %></div>
                <% } %>

                <form method="POST" action="<%= contextPath %>/reservations" class="form" id="reservationForm">
                    <input type="hidden" name="action" value="reserve">
                    <input type="hidden" id="id_tarif" name="id_tarif">
                    <input type="hidden" id="id_type_passager" name="id_type_passager" value="1">
                    <input type="hidden" id="id_classe_hidden" name="id_classe">
                    <div id="sieges-selected-container"></div>

                    <!-- ÉTAPE 1: Sélection de la date -->
                    <div class="step-section">
                        <h3>Étape 1: Sélectionnez une date de départ</h3>
                        <div class="form-group">
                            <label for="date_depart">Date de départ *</label>
                            <input type="date" id="date_depart" name="date_depart" required class="form-control" value="<%= dateOnly %>">
                        </div>
                    </div>

                    <!-- ÉTAPE 2: Sélection du vol -->
                    <div class="step-section">
                        <h3>Étape 2: Sélectionnez un vol</h3>
                        <div class="form-group">
                            <label for="id_vol_planifie">Vol disponible *</label>
                            <select id="id_vol_planifie" name="id_vol_planifie" required disabled class="form-select">
                                <option value="">-- Sélectionner une date d'abord --</option>
                            </select>
                        </div>
                        <div id="flight-details" style="display: none; margin-top: 15px; padding: 15px; background: white; border-radius: 6px; border: 1px solid var(--border-color);">
                            <div class="row">
                                <div class="col-md-4">
                                    <p style="color: var(--gray-medium); font-size: 0.9em; margin-bottom: 5px;">Avion</p>
                                    <p style="font-weight: 600; color: var(--primary-violet);" id="flight-avion">--</p>
                                </div>
                                <div class="col-md-4">
                                    <p style="color: var(--gray-medium); font-size: 0.9em; margin-bottom: 5px;">Départ</p>
                                    <p style="font-weight: 600; color: var(--primary-violet);" id="flight-depart">--</p>
                                </div>
                                <div class="col-md-4">
                                    <p style="color: var(--gray-medium); font-size: 0.9em; margin-bottom: 5px;">Capacité</p>
                                    <p style="font-weight: 600; color: var(--primary-violet);" id="flight-capacite">--</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ÉTAPE 3: Sélection de la classe -->
                    <div class="step-section">
                        <h3>Étape 3: Sélectionnez une classe</h3>
                        <div class="form-group">
                            <label for="classe">Classe *</label>
                            <select id="classe" name="classe" required disabled class="form-select">
                                <option value="">-- Sélectionner un vol d'abord --</option>
                            </select>
                            <small id="tarif-info" style="display:block;color:var(--primary-blue);margin-top:6px;"></small>
                        </div>
                    </div>

                    <!-- ÉTAPE 4: Sélection du siège -->
                    <div class="step-section">
                        <h3>Étape 4: Sélectionnez un siège</h3>
                        <div class="siege-legend">
                            <div class="legend-item">
                                <div class="legend-box available"></div>
                                <span>Disponible</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-box occupied"></div>
                                <span>Occupé</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-box selected"></div>
                                <span>Sélectionné</span>
                            </div>
                        </div>
                        <div style="text-align: center; margin-bottom: 10px;">
                            <span style="font-weight: 600; color: var(--primary-violet);" id="selected-count">0 siège(s) sélectionné(s)</span>
                        </div>
                        <div class="cockpit">✈️ Avant de l'avion</div>
                        <div id="siege-container">
                            <div class="siege-grid">
                                <div style="grid-column: 1/-1; text-align: center; color: var(--gray-medium);">-- Sélectionner un vol --</div>
                            </div>
                        </div>
                        <div class="seat-navigation" id="seat-navigation" style="display: none;">
                            <button type="button" class="nav-btn" id="prev-btn" onclick="previousPage()">
                                <span>←</span> Précédent
                            </button>
                            <span class="page-info" id="page-info">Rangées 1-5</span>
                            <button type="button" class="nav-btn" id="next-btn" onclick="nextPage()">
                                Suivant <span>→</span>
                            </button>
                        </div>
                        <input type="hidden" id="id_siege" name="id_siege" required>
                    </div>

                    <!-- ÉTAPE 5: Informations passager -->
                    <div class="step-section">
                        <h3>Étape 5: Informations Passager</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="prenom">Prénom *</label>
                                    <input type="text" id="prenom" name="prenom" required placeholder="Votre prénom" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="nom">Nom *</label>
                                    <input type="text" id="nom" name="nom" required placeholder="Votre nom" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="date_naissance">Date de Naissance *</label>
                                    <input type="date" id="date_naissance" name="date_naissance" required class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="nationalite">Nationalité *</label>
                                    <input type="text" id="nationalite" name="nationalite" required placeholder="Votre nationalité" class="form-control">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="email">Email *</label>
                                    <input type="email" id="email" name="email" required placeholder="votre@email.com" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="telephone">Téléphone *</label>
                                    <input type="tel" id="telephone" name="telephone" required placeholder="+33 6 12 34 56 78" class="form-control">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-primary">
                            Confirmer la Réservation
                        </button>
                        <a href="<%= contextPath %>/reservations" class="btn btn-secondary">
                            Annuler
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <footer>
        <p>&copy; 2026 Compagnie Aérienne</p>
    </footer>

    <!-- Modal sélection type passager -->
    <div id="passengerTypeModal" style="display:none; position:fixed; inset:0; background:rgba(0,0,0,0.45); align-items:center; justify-content:center; z-index:9999;">
        <div style="background:white; padding:24px; border-radius:8px; width:320px; box-shadow:0 8px 30px rgba(0,0,0,0.25);">
            <h5 style="margin-bottom:12px; color:var(--primary-violet);">Type de passager</h5>
            <select id="passengerTypeSelect" class="form-select" aria-label="Type de passager">
                <option value="1">Adulte</option>
                <option value="2">Enfant</option>
                <option value="3">Bébé</option>
                <option value="4">Senior</option>
            </select>
            <div style="margin-top:16px; display:flex; gap:10px; justify-content:flex-end;">
                <button type="button" class="btn btn-secondary" onclick="closePassengerTypeModal()">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="confirmPassengerType()">Valider</button>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '<%= contextPath %>';
        const preselectedVolId = '<%= idVolParam != null ? idVolParam : "" %>';
        const preselectedDate = '<%= dateOnly %>';
        
        let allSeatsData = [];
        let currentPage = 0;
        const ROWS_PER_PAGE = 5;
        let selectedSeats = [];
        let passengerTypeChosen = false;
        
        console.log('Preselected Vol ID:', preselectedVolId);
        console.log('Preselected Date:', preselectedDate);
        
        // Auto-load flights if date is pre-filled
        window.addEventListener('DOMContentLoaded', function() {
            if (preselectedDate) {
                console.log('Auto-loading flights for date:', preselectedDate);
                loadFlights(preselectedDate);
            }
        });
        
        function loadFlights(date) {
            if (date) {
                fetch(contextPath + '/reservations?action=getVolsByDate&date=' + date)
                    .then(r => r.json())
                    .then(data => {
                        console.log('Flights loaded:', data);
                        const select = document.getElementById('id_vol_planifie');
                        select.innerHTML = '<option value="">-- Sélectionner un vol --</option>';
                        select.disabled = false;
                        data.forEach(vol => {
                            const selected = preselectedVolId && vol.id == preselectedVolId ? ' selected' : '';
                            select.innerHTML += '<option value="' + vol.id + '"' + selected + '>' + vol.codeVol + '</option>';
                        });
                        
                        // If a vol is preselected, trigger its change event to load details
                        if (preselectedVolId && data.some(vol => vol.id == preselectedVolId)) {
                            console.log('Triggering change event for preselected vol:', preselectedVolId);
                            setTimeout(() => {
                                const event = new Event('change');
                                select.dispatchEvent(event);
                            }, 200);
                        }
                    })
                    .catch(err => console.error('Erreur chargement vols:', err));
            }
        }
        
        // AJAX for dynamic loading of flights
        document.getElementById('date_depart').addEventListener('change', function() {
            loadFlights(this.value);
        });

        // Load seats and classes when flight is selected
        document.getElementById('id_vol_planifie').addEventListener('change', function() {
            const volId = this.value;
            const classeSelect = document.getElementById('classe');
            // Reset tarification, classe et sélection
            document.getElementById('id_tarif').value = '';
            document.getElementById('tarif-info').textContent = 'Tarif: --';
            document.getElementById('id_classe_hidden').value = '';
            selectedSeats = [];
            updateSelectedSeatsDisplay();
            if (volId) {
                // Load flight details and available seats/classes
                fetch(contextPath + '/reservations?action=getVolDetails&vol=' + volId)
                    .then(r => r.json())
                    .then(vol => {
                        // Display flight details
                        document.getElementById('flight-details').style.display = 'block';
                        document.getElementById('flight-avion').textContent = vol.avion || '--';
                        document.getElementById('flight-depart').textContent = vol.depart || '--';
                        document.getElementById('flight-capacite').textContent = vol.capacite + ' places';
                        
                        // Load classes
                        classeSelect.innerHTML = '<option value="">-- Sélectionner une classe --</option>';
                        if (vol.classes && vol.classes.length > 0) {
                            vol.classes.forEach(classe => {
                                classeSelect.innerHTML += '<option value="' + classe + '">' + classe + '</option>';
                            });
                            classeSelect.disabled = false;
                        } else {
                            classeSelect.disabled = true;
                        }
                    })
                    .catch(err => console.error('Erreur chargement vol:', err));
                    
                // Load all seats (for display only, not filtered)
                fetch(contextPath + '/reservations?action=getSieges&vol=' + volId)
                    .then(r => r.json())
                    .then(data => {
                        displaySeats(data);
                    })
                    .catch(err => console.error('Erreur chargement sièges:', err));
            }
        });

        function displaySeats(seats) {
            if (!seats || seats.length === 0) {
                document.getElementById('siege-container').innerHTML = 
                    '<div class="siege-grid"><div style="grid-column: 1/-1; text-align: center;">Aucun siège disponible</div></div>';
                document.getElementById('seat-navigation').style.display = 'none';
                return;
            }
            
            allSeatsData = seats;
            currentPage = 0;
            renderSeatsPage();
        }
        
        function renderSeatsPage() {
            // Group seats by row number
            const seatsByRow = {};
            allSeatsData.forEach(seat => {
                // Extract row number (e.g., "1A" => "1")
                const rowNum = seat.numero.replace(/[A-Z]/g, '');
                if (!seatsByRow[rowNum]) {
                    seatsByRow[rowNum] = [];
                }
                seatsByRow[rowNum].push(seat);
            });
            
            // Sort rows numerically
            const sortedRows = Object.keys(seatsByRow).sort((a, b) => parseInt(a) - parseInt(b));
            
            // Calculate pagination
            const startIdx = currentPage * ROWS_PER_PAGE;
            const endIdx = Math.min(startIdx + ROWS_PER_PAGE, sortedRows.length);
            const pageRows = sortedRows.slice(startIdx, endIdx);
            
            let html = '<div class="siege-grid">';
            
            pageRows.forEach(rowNum => {
                const rowSeats = seatsByRow[rowNum].sort((a, b) => {
                    const seatA = a.numero.replace(/[0-9]/g, '');
                    const seatB = b.numero.replace(/[0-9]/g, '');
                    return seatA.localeCompare(seatB);
                });
                
                // Create row with label
                html += '<div class="siege-row">';
                html += '<div class="row-label">' + rowNum + '</div>';
                
                // Fill seats in order (A, B, C, D, E, F)
                const columns = ['A', 'B', 'C', 'D', 'E', 'F'];
                columns.forEach(col => {
                    const seat = rowSeats.find(s => s.numero === rowNum + col);
                    if (seat) {
                        html += '<button type="button" class="siege-btn' + (seat.disponible ? '' : ' disabled') + 
                                '" data-seat="' + seat.id + '" onclick="selectSeat(event, ' + seat.id + ')" ' +
                                (!seat.disponible ? 'disabled' : '') + '>' +
                                '<div class="numero">' + seat.numero + '</div>' +
                                '<div class="classe-badge">' + (seat.classe || 'ECO') + '</div>' +
                                '</button>';
                    } else {
                        html += '<div></div>'; // Empty space for alignment
                    }
                });
                
                html += '</div>';
            });
            
            html += '</div>';
            document.getElementById('siege-container').innerHTML = html;
            
            // Update navigation
            const totalPages = Math.ceil(sortedRows.length / ROWS_PER_PAGE);
            if (totalPages > 1) {
                document.getElementById('seat-navigation').style.display = 'flex';
                document.getElementById('prev-btn').disabled = currentPage === 0;
                document.getElementById('next-btn').disabled = currentPage >= totalPages - 1;
                
                const startRow = sortedRows[startIdx];
                const endRow = sortedRows[endIdx - 1];
                document.getElementById('page-info').textContent = 
                    'Rangées ' + startRow + '-' + endRow + ' (' + (currentPage + 1) + '/' + totalPages + ')';
            } else {
                document.getElementById('seat-navigation').style.display = 'none';
            }
        }
        
        function previousPage() {
            if (currentPage > 0) {
                currentPage--;
                renderSeatsPage();
            }
        }
        
        function nextPage() {
            currentPage++;
            renderSeatsPage();
        }

        function selectSeat(event, seatId) {
            event.preventDefault();
            const btn = event.target.closest('.siege-btn');

            if (!passengerTypeChosen) {
                openPassengerTypeModal();
            }
            
            // Toggle selection
            if (selectedSeats.includes(seatId)) {
                // Déselectionner
                selectedSeats = selectedSeats.filter(id => id !== seatId);
                btn.classList.remove('selected');
            } else {
                // Sélectionner
                selectedSeats.push(seatId);
                btn.classList.add('selected');
            }
            
            updateSelectedSeatsDisplay();
        }
        
        function updateSelectedSeatsDisplay() {
            // Mettre à jour le compteur
            document.getElementById('selected-count').textContent = 
                selectedSeats.length + ' siège(s) sélectionné(s)';
            
            // Créer les champs hidden pour chaque siège
            const container = document.getElementById('sieges-selected-container');
            container.innerHTML = '';
            selectedSeats.forEach(seatId => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'id_sieges';
                input.value = seatId;
                container.appendChild(input);
            });
        }

        function openPassengerTypeModal() {
            document.getElementById('passengerTypeModal').style.display = 'flex';
        }

        function closePassengerTypeModal() {
            document.getElementById('passengerTypeModal').style.display = 'none';
        }

        function confirmPassengerType() {
            const typeVal = document.getElementById('passengerTypeSelect').value;
            document.getElementById('id_type_passager').value = typeVal;
            passengerTypeChosen = true;
            closePassengerTypeModal();
        }

        // Load seats when class is selected
        document.getElementById('classe').addEventListener('change', function() {
            const volId = document.getElementById('id_vol_planifie').value;
            const classe = this.value;
            if (volId && classe) {
                selectedSeats = [];
                updateSelectedSeatsDisplay();

                // Fetch tariff - server will look up class ID by libelle (handles accents robustly)
                fetch(contextPath + '/reservations?action=getTarif&vol=' + volId + '&classe=' + encodeURIComponent(classe))
                    .then(r => {
                        if (!r.ok) throw new Error('Tarif introuvable');
                        return r.json();
                    })
                    .then(tarif => {
                        document.getElementById('id_tarif').value = tarif.idTarif;
                        document.getElementById('id_classe_hidden').value = tarif.classeId;
                        document.getElementById('tarif-info').textContent = 'Tarif: ' + Math.round(tarif.prix) + ' Ar';
                    })
                    .catch(err => {
                        document.getElementById('tarif-info').textContent = 'Tarif: --';
                        console.error(err);
                        // alert('Tarif introuvable pour cette classe');
                    });

                fetch(contextPath + '/reservations?action=getSieges&vol=' + volId + '&classe=' + classe)
                    .then(r => r.json())
                    .then(data => {
                        displaySeats(data);
                    })
                    .catch(err => console.error('Erreur chargement sièges:', err));
            }
        });
    </script>
</body>
</html>

