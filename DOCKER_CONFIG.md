# Configuration Docker pour Compagnie Aérienne

## Prérequis
- Docker Desktop installé
- Docker Compose installé

## Démarrage

```bash
# Démarrer les services
docker-compose up -d

# Afficher les logs
docker-compose logs -f

# Arrêter les services
docker-compose down
```

## Configuration

### PostgreSQL
- **Host**: postgres (dans le réseau Docker) / localhost (depuis l'hôte)
- **Port**: 5432
- **User**: aero_user
- **Password**: aero_password
- **Database**: compagnie_aero

### Java Application
- **Port**: 8080
- **Version Java**: 17

## Commandes utiles

```bash
# Voir l'état des conteneurs
docker-compose ps

# Accéder à la base de données
docker exec -it compagnie_aero_db psql -U aero_user -d compagnie_aero

# Voir les logs d'une application
docker-compose logs java_app
docker-compose logs postgres

# Reconstruire l'image Java
docker-compose build --no-cache java_app
```

## Structure du projet attendue

```
Compagnie_aero/
├── docker-compose.yml      # Orchestration des services
├── bdd/
│   └── table.sql          # Schéma importé au démarrage
└── src/                    # Code source Java (si applicable)
```

## Notes

- Le schéma SQL (`table.sql`) est automatiquement importé au démarrage du conteneur PostgreSQL
- Les données PostgreSQL sont persistées dans un volume Docker
- Les services communiquent via le réseau Docker `aero_network`
