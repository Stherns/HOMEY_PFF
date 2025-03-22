*** Settings ***
Library    SeleniumLibrary
# Resource    commun.resource
# Suite Setup    MOTCLE1    (Executer avant le premier cas de test la suite de test)
# Suite Teardown    MOTCLE2    (Executer apres le dernier cas de test de la suite de test)

*** Variables ***

# --- EFFECTUER UNE CONNEXION REUSSIE ---

${SERVEUR}    livraison3.testacademy.fr
${HOMEY URL}    http://${SERVEUR}/
${NAVIGATEUR}    Chrome
${LIEN SE CONNECTER}    xpath=//a[contains(text(),'Se connecter')]
${LIEN SE DECONNECTER}    xpath=(//a[contains(text(),'Se déconnecter')])[3]
${UTILISATEUR VALIDE}    stherns
# ${UTILISATEUR NON VALIDE}    nonvalide
${MOT DE PASSE VALIDE}    stherns
# ${MOT DE PASSE NON VALIDE}    nonvalide
${CHAMP NOM UTILISATEUR}    name=username
${CHAMP MOT DE PASSE}    name=password
${BOUTON VALIDER}    css=.homey_login_button
${TITRE TABLEAU DE BORD}    Tableau de bord - Livraison 3
# ${ESPACE POUR AFFICHER LES ERREURS}    css=#modal-login .error
# ${TITRE ACCEUIL}    Accueil - Livraison 3

# --- RESERVATION D'UN LOGEMENT ---

${LIEN LOGO}    xpath=//a[contains(text(),'Accueil')]
${CHAMP DATE DEBUT}    name=arrive
${DATE DEBUT}    2025-06-17
${CHAMP DATE FIN}    name=depart
${DATE FIN}    2025-06-23
${CHAMP NOMBRE VOYAGEURS}    xpath=//div[3]/input
${NOMBRE VOYAGEURS}   
${VOYAGEUR ADULTES}    css=.banner-caption .search_adult_plus > .fa
${VOYAGEURS ENFANTS}    css=.banner-caption .search_child_plus > .fa
${ANIMAUX DOMESTIQUES}    css=.banner-caption .control:nth-child(1) > .radio-tab-inner
${BOUTON VALIDER VOYAGEURS}    css=.banner-caption .guest-apply-btn > .btn
${BOUTON CHERCHER}    css=.search-button > .btn-primary:nth-child(1)
${CHOIX CHAMBRE}    xpath=//div[@id='homey_halfmap_listings_container']/div/div/div/div/a
${CONTACTEZ L'HOTE}    css=.btn-full-width:nth-child(2)
${CHAMP NOM}    name=name
${NOM}    Djhery MOUSSAVOU
${CHAMP EMAIL}    name=email
${EMAIL}    stherns@yahoo.fr
${CHAMP TELEPHONE}    name=phone
${TELEPHONE}    0758978822
${CHAMP MESSAGE}    name=message
${MESSAGE}    Bonjour, je suis intéressé par votre logement.
${BOUTON VALIDER MESSAGE}    xpath=//button[@type='submit']
${ONGLET FERMER}    xpath=//div[2]/div/div/div/div/button/span
${BOUTON RESERVATION}    xpath=//div[2]/div/button
${CLIC DANS LE VIDE}    css=.main-content-area
${ICON UTILISATEUR}    css=.account-loggedin
${ONGLET RESERVATIONS}    xpath=//a[@href='http://livraison3.testacademy.fr/index.php/reservations/']
${BOUTON DETAILS}    xpath=//a[contains(text(),'Détails')]

# --- ANNULATION DE RESERVATION ---

${BOUTON ANNULER}    css=.dashboard-sidebar > #cancel-reservation-btn
${REASON}    id=reason
${raison}    Je ne suis plus intéressé par le logement.
${BOUTON SOUMETTRE RAISON}    id=cancelled

# --- VERIFICATION DE LA RESERVATION ---

${AFFICHAGE MESSAGE ERREUR}    xpath=//div[@id='homey_remove_on_mobile']/div/div[2]/div/div

*** Test Cases ***

Champ nombre de voyageurs vide
    1. Ouvrir le site web de réservation
    2. Se connecter avec un compte utilisateur valide
    3. Accéder à la section de réservation
    4. Saisir une date de début valide
    5. Saisir une date de fin valide
    6. Laisser le champ "Nombre de voyageurs" vide
    7. Ajouter un message à l’attention de l’hôte
    8. Valider la demande de réservation
    9. Vérifier que la réservation n'est pas enregistrée
    Close Browser

*** Keywords ***

1. Ouvrir le site web de réservation
    Ouvrir Le Navigateur Et Accéder A La Page d'Accueil

Ouvrir Le Navigateur Et Accéder A La Page d'Accueil
    Open Browser    browser=${navigateur}   # executable_path=${CHROMEDRIVER_PATH}
    Go To    ${HOMEY URL}
    Maximize Browser Window

2. Se connecter avec un compte utilisateur valide
    Accéder A La Page De Connexion
    Entrer Le Nom d'Utilisateur    ${UTILISATEUR VALIDE}
    Entrer Le Mot De Passe    ${MOT DE PASSE VALIDE}
    Soumettre Le Formulaire De Connexion
    Vérifiez Que Le Tableau De Bord Est Visible

Accéder A La Page De Connexion
    Click Element    ${LIEN SE CONNECTER}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}

Entrer Le Nom d'Utilisateur
    [Arguments]    ${nom_utilisateur}
    Click Element     ${CHAMP NOM UTILISATEUR}
    Input Text    ${CHAMP NOM UTILISATEUR}    ${nom_utilisateur}

Entrer Le Mot De Passe
    [Arguments]    ${mot_de_passe}
    Click Element     ${CHAMP MOT DE PASSE}
    Input Text    ${CHAMP MOT DE PASSE}    ${mot_de_passe}

Soumettre Le Formulaire De Connexion
   Click Button    ${BOUTON VALIDER}

Vérifiez Que Le Tableau De Bord Est Visible
    Wait Until Element Is Not Visible   ${CHAMP NOM UTILISATEUR}
    Title Should Be    ${TITRE TABLEAU DE BORD}

3. Accéder à la section de réservation
    Accéder A La Page De Reservation

Accéder A La Page De Reservation
    Click Element    ${LIEN LOGO}
    Wait Until Element Is Visible    ${CHAMP DATE DEBUT}

4. Saisir une date de début valide
    Entrer La Date de Debut    ${DATE DEBUT}

Entrer La Date de Debut
    [Arguments]    ${date_debut}
    Click Element     ${CHAMP DATE DEBUT}
    Input Text    ${CHAMP DATE DEBUT}    ${date_debut}

5. Saisir une date de fin valide
    Entrer La Date de Fin    ${DATE FIN}

Entrer La Date de Fin
    [Arguments]    ${date_fin}
    Click Element     ${CHAMP DATE FIN}
    Input Text    ${CHAMP DATE FIN}    ${date_fin}

6. Laisser le champ "Nombre de voyageurs" vide
    Ne Pas Entrer Le Nombre de Voyageurs    ${NOMBRE VOYAGEURS}
    Cliquer Sur Le Bouton De Validation

Ne Pas Entrer Le Nombre de Voyageurs
    [Arguments]    ${nombre_voyageurs}
    Click Element     ${CHAMP NOMBRE VOYAGEURS}
    Input Text    ${CHAMP NOMBRE VOYAGEURS}    ${nombre_voyageurs}
    # Double Click Element    ${VOYAGEUR ADULTES}
    # Click Element    ${VOYAGEURS ENFANTS}
    # Click Element    ${ANIMAUX DOMESTIQUES}
    
Cliquer Sur Le Bouton De Validation
    Click Element    ${BOUTON VALIDER VOYAGEURS}
    Click Button    ${BOUTON CHERCHER}

7. Ajouter un message à l’attention de l’hôte
    Choix De La Chambre
    Contactez L'Hote
    Entrer Le Nom    ${NOM}
    Entrer L'Email    ${EMAIL}
    Entrer Le Telephone    ${TELEPHONE}
    Entrer Le Message    ${MESSAGE}
    Soumettre Le Formulaire De Message
    Fermer la fenêtre de message
    
Choix De La Chambre
    Wait Until Element Is Visible    ${CHOIX CHAMBRE}
    Click Element    ${CHOIX CHAMBRE}
    Wait Until Element Is Visible    ${CLIC DANS LE VIDE}

Contactez L'Hote
    Click Element    ${CONTACTEZ L'HOTE}
    Wait Until Element Is Visible    ${CHAMP NOM}

Entrer Le Nom
    [Arguments]    ${NOM}
    Click Element    ${CHAMP NOM}
    Input Text    ${CHAMP NOM}    ${NOM}

Entrer L'Email
    [Arguments]    ${email}
    Click Element    ${CHAMP EMAIL}
    Input Text    ${CHAMP EMAIL}    ${EMAIL}

Entrer Le Telephone
    [Arguments]    ${telephone}
    Click Element    ${CHAMP TELEPHONE}
    Input Text    ${CHAMP TELEPHONE}    ${TELEPHONE}

Entrer Le Message
    [Arguments]    ${message}
    Click Element    ${CHAMP MESSAGE}
    Input Text    ${CHAMP MESSAGE}    ${MESSAGE}

Soumettre Le Formulaire De Message
    Click Button    ${BOUTON VALIDER MESSAGE}

Fermer la fenêtre de message
    Click Element    ${ONGLET FERMER}

8. Valider la demande de réservation
    # Choix de la Chambre
    Cliquer Sur Le Bouton De Demande De Reservation
    Vérifier Que L'Espace Pour Afficher Les Erreurs Est Visible

# Choix de la Chambre
#     Wait Until Element Is Visible    ${CHOIX CHAMBRE}
#     Click Element    ${CHOIX CHAMBRE}
#     Wait Until Element Is Visible    ${CLIC DANS LE VIDE}

Cliquer Sur Le Bouton De Demande De Reservation
    Click Element    ${CLIC DANS LE VIDE}
    Click Button    ${BOUTON RESERVATION}
    Click Element    ${CLIC DANS LE VIDE}

Vérifier Que L'Espace Pour Afficher Les Erreurs Est Visible
    Element Should Be Visible    ${AFFICHAGE MESSAGE ERREUR}

9. Vérifier que la réservation n'est pas enregistrée
    Accéder A La Section Des Reservations
    Effectuer Une Déconnexion Réussie
    Vérifier Que Le Lien De Connexion Est Visible
    Close Browser

Accéder A La Section Des Reservations
    Click Element    ${ICON UTILISATEUR}
    Wait Until Element Is Visible    ${ONGLET RESERVATIONS}
    Click Element    ${ONGLET RESERVATIONS}

Effectuer Une Déconnexion Réussie
    Click Element    ${LIEN SE DECONNECTER}

Vérifier Que Le Lien De Connexion Est Visible
    Wait Until Element Is Not Visible    ${LIEN SE DECONNECTER}
    Element Should Be Visible    ${LIEN SE CONNECTER}
