# 🚀 Guide d'Installation et Déploiement

## Prérequis

### Système
- Windows 10+, macOS 10.14+ ou Linux (Ubuntu 20.04+)
- 4 GB RAM minimum
- 2 GB espace disque libre

### Logiciels à installer

#### 1. Java 17 JDK
```bash
# Windows : Télécharger depuis oracle.com
# macOS (Homebrew)
brew install openjdk@17

# Linux (Ubuntu)
sudo apt-get install openjdk-17-jdk
```

Vérifier l'installation :
```bash
java -version
javac -version
```

#### 2. Apache Maven 3.8+
```bash
# Windows : Télécharger depuis maven.apache.org
# macOS
brew install maven

# Linux
sudo apt-get install maven
```

Vérifier :
```bash
mvn -version
```

#### 3. PostgreSQL 14+
```bash
# Windows : Installer depuis postgresql.org
# macOS
brew install postgresql

# Linux
sudo apt-get install postgresql postgresql-contrib
```

Vérifier :
```bash
psql --version
```

#### 4. Apache Tomcat 9+
```bash
# Télécharger depuis tomcat.apache.org
# Décompresser et configurer CATALINA_HOME
```

---

## Installation Base de Données

### 1. Créer la base de données

```sql
-- Connexion à PostgreSQL
psql -U postgres

-- Créer la base
CREATE DATABASE compagnie_aerienne;

-- Créer l'utilisateur
CREATE USER aero_user WITH PASSWORD 'aero_password';

-- Accorder les droits
GRANT ALL PRIVILEGES ON DATABASE compagnie_aerienne TO aero_user;
```

### 2. Exécuter le script de création

```bash
psql -U aero_user -d compagnie_aerienne -f sql/script.sql
```

Ou depuis pgAdmin :
1. Connexion à PostgreSQL
2. Créer la base `compagnie_aerienne`
3. Ouvrir l'outil de requête SQL
4. Copier-coller le contenu de `script.sql`
5. Exécuter

### 3. Vérifier les tables

```sql
\d -- Lister les tables
SELECT COUNT(*) FROM avion; -- Vérifier les données
```

---

## Configuration de l'Application

### 1. Modifier les credentials JDBC

Fichier : `src/main/java/com/aero/util/DatabaseConnection.java`

```java
// À adapter selon votre configuration
private static final String URL = "jdbc:postgresql://localhost:5432/compagnie_aerienne";
private static final String USER = "aero_user";      // Votre utilisateur PostgreSQL
private static final String PASSWORD = "aero_password"; // Votre mot de passe
```

### 2. Configuration Maven (optionnel)

Fichier : `pom.xml` est déjà configuré, mais vérifier :
- Version Java : `<maven.compiler.source>17</maven.compiler.source>`
- Version Tomcat : Plugin tomcat7

---

## Compilation et Build

### 1. Compiler le projet

```bash
cd CompagnieAerienne
mvn clean compile
```

### 2. Exécuter les tests (s'il y en a)

```bash
mvn test
```

### 3. Packager en WAR

```bash
mvn clean package
```

Résultat : `target/compagnie-aerienne.war`

---

## Déploiement sur Tomcat

### Méthode 1 : Copier le WAR

```bash
# Copier le WAR dans le répertoire webapps
cp target/compagnie-aerienne.war $TOMCAT_HOME/webapps/

# Redémarrer Tomcat
$TOMCAT_HOME/bin/shutdown.sh
$TOMCAT_HOME/bin/startup.sh
```

### Méthode 2 : Manager Tomcat

1. Ouvrir http://localhost:8080/manager/html
2. Username: `admin` / Password: `admin` (par défaut)
3. Section "Deploy"
   - WAR file: `target/compagnie-aerienne.war`
   - Context Path: `/compagnie-aerienne`
   - Cliquer "Deploy"

### Méthode 3 : Plugin Maven

```bash
mvn tomcat7:deploy
# ou
mvn tomcat7:redeploy
```

---

## Vérification du Déploiement

### 1. Vérifier Tomcat

```bash
# Logs Tomcat
tail -f $TOMCAT_HOME/logs/catalina.out
```

### 2. Accéder l'application

```
http://localhost:8080/compagnie-aerienne
```

Vous devriez voir :
- Page d'accueil avec 5 modules (Avions, Aéroports, Vols, Vols Planifiés, Réservations)
- Menu de navigation
- Responsive design

### 3. Tester une fonctionnalité

```
1. Cliquer sur "Avions"
2. Vous devez voir la liste pré-remplie depuis script.sql
3. Tester "Ajouter un Avion"
```

---

## Troubleshooting

### Erreur : "Driver PostgreSQL non trouvé"

**Solution** :
- Vérifier que la dépendance PostgreSQL est dans pom.xml
- Recompiler : `mvn clean package`
- Le JAR `postgresql-*.jar` doit être dans `$TOMCAT_HOME/lib/`

### Erreur : "Connection refused"

**Solution** :
- Vérifier que PostgreSQL est en cours d'exécution
- Vérifier credentials dans `DatabaseConnection.java`
- Test de connexion :
```bash
psql -U aero_user -d compagnie_aerienne -h localhost
```

### Erreur 404 - Page non trouvée

**Solution** :
- Vérifier l'URL : `http://localhost:8080/compagnie-aerienne`
- Vérifier dans Tomcat Manager que l'application est déployée
- Voir les logs : `$TOMCAT_HOME/logs/catalina.out`

### Erreur SQL - Tables non trouvées

**Solution** :
- Vérifier que script.sql a été complètement exécuté
- Vérifier le user et les permissions dans PostgreSQL
- Tester :
```sql
\c compagnie_aerienne
\d -- Lister les tables
```

### Port 8080 déjà utilisé

**Solution** :
```bash
# Changer le port dans $TOMCAT_HOME/conf/server.xml
<Connector port="8081" ... />

# Puis redémarrer Tomcat
```

---

## Structure Répertoires Installation

```
tomcat-home/
├── bin/
│   ├── startup.sh
│   └── shutdown.sh
├── conf/
│   ├── server.xml
│   └── context.xml
├── lib/
│   ├── postgresql-42.7.1.jar ◄── Driver JDBC
│   └── ... autres JARs
├── webapps/
│   ├── compagnie-aerienne/  ◄── Application déployée
│   ├── manager/
│   └── ROOT/
├── logs/
│   └── catalina.out         ◄── Logs d'exécution
└── work/
    └── Catalina/
        └── localhost/
            └── compagnie-aerienne/
```

---

## Développement Local (Sans déploiement)

### Utiliser Maven Jetty Plugin (optionnel)

Ajouter à `pom.xml` :
```xml
<plugin>
    <groupId>org.eclipse.jetty</groupId>
    <artifactId>jetty-maven-plugin</artifactId>
    <version>9.4.52.v20230823</version>
    <configuration>
        <httpConnector>
            <port>8080</port>
        </httpConnector>
    </configuration>
</plugin>
```

Exécuter :
```bash
mvn jetty:run
```

Application disponible à : `http://localhost:8080/`

---

## Performance et Optimisation

### Recommandations

1. **Pool de connexions JDBC**
   - Implémenter DataSource avec pool
   - Exemple : HikariCP

2. **Caching**
   - Cache les listes fréquemment consultées
   - Redis ou Memcached

3. **Indexation BD**
   - Indices sur clés étrangères
   - Indices sur colonnes de recherche

4. **Logs**
   - Utiliser Log4J au lieu de System.out
   - Rotation des logs

---

## Backup et Restore

### Backup de la base

```bash
# Dump complète
pg_dump -U aero_user compagnie_aerienne > backup.sql

# Restore
psql -U aero_user compagnie_aerienne < backup.sql
```

### Backup application

```bash
tar -czf backup-compagnie-aerienne.tar.gz CompagnieAerienne/
```

---

## Sécurité en Production

### À faire avant déploiement

1. ✅ Changer les mots de passe par défaut
2. ✅ Configurer HTTPS
3. ✅ Ajouter authentification utilisateur
4. ✅ Implémenter CSRF protection
5. ✅ Activer WAF (Web Application Firewall)
6. ✅ Configurer les logs de sécurité
7. ✅ Limiter les accès à la BD
8. ✅ Tester les injections SQL
9. ✅ Activer les sessions sécurisées

---

## Support et Documentation

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Apache Tomcat Documentation](https://tomcat.apache.org/)
- [Maven Documentation](https://maven.apache.org/)
- [Java 17 Documentation](https://docs.oracle.com/en/java/javase/17/)

---

**Généré pour installation de Compagnie Aérienne v1.0**
