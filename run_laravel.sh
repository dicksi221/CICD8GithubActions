#!/bin/bash

# Définir la version de PHP
PHP_VERSION="8.2"
cd test.awahustracking.com
# Vérifier si le fichier .env existe, sinon le copier depuis .env.example
echo "Copying .env file..."
php -r "file_exists('.env') || copy('.env.example', '.env');"

# Créer le répertoire de logs s'il n'existe pas
echo "Creating logs directory..."
mkdir -p storage/logs

# Installer les dépendances PHP
echo "Installing PHP dependencies..."
composer install
composer require maatwebsite/excel

# Installer les dépendances Node.js
echo "Installing Node dependencies..."
npm install

# Générer la clé de l'application Laravel
echo "Generating application key..."
php artisan key:generate

# Définir les permissions des répertoires storage et bootstrap/cache
echo "Setting directory permissions..."
chmod -R 755 storage bootstrap/cache

# Mettre en cache la configuration
echo "Caching configuration..."
php artisan config:cache

# Mettre en cache les vues
echo "Caching views..."
php artisan view:cache

echo "Setup completed successfully."
