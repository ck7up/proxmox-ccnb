#!/usr/bin/env bash

# Script pour télécharger tous les templates de PVEAM et les enregistrer dans vortex-lvm
# Auteur : Christian Kalla

STORAGE="vortex-lvm" # Définir le stockage cible
SECTION="turnkeylinux" # Définir la section des templates à télécharger

echo "Début du téléchargement des templates de la section '$SECTION' vers '$STORAGE'..."

# Récupérer tous les templates disponibles dans la section spécifiée
for template in $(pveam available --section "$SECTION" | awk 'NR>1 {print $2}'); do 
  # Vérifier si le template existe déjà
  if pveam list "$STORAGE" | grep -q "$template"; then
    echo "Le template '$template' existe déjà dans '$STORAGE'. Passage au suivant..."
    continue
  fi

  echo "Téléchargement du template : $template..."
  pveam download "$STORAGE" "$template"
  echo "Téléchargement terminé pour : $template"
done

echo "Tous les templates de '$SECTION' ont été traités dans '$STORAGE'."

# @By VortexOps
