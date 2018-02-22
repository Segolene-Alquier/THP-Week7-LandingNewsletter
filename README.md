# Landing page pour inscription
## La création de la landing page
### Choix du design
On s'est pas cassé la tête, on a cherché un template bootstrap de landing page gratos, et on a téléchargé celui-ci qui nous convenait bien :
https://startbootstrap.com/template-overviews/creative/

On a choisi cette landing parce qu'elle était plutôt épurée et donnait la possibilité d'intégrer des témoignages de corsaire facilement (et gratuite, je l'ai déjà dit 😬 ?).

### Comment on l'a codé
#### Configuration bootstrap
- On a créé une app rails et on a fait en sorte qu'elle soit heroku-friendly
- on a ajouté la gem 'frontend-generators'
- dans le rakefile : ``` require "frontend_generators"```
- Définir la root dans routes.rb
- On a rajouté les fichiers css et js dans l'asset pipeline
- ```bundle exec rake add_assets:bootstrap```
- Ajouter dans 'application.css' ```*= require bootstrap```
- Ajouter dans 'application.js' : ```//= require bootstrap```
- Ajouter les noms des fichiers .css dans 'config/initializers/assets.rb' via :
```Rails.application.config.assets.precompile += %w( creative/XXXX.js )```

#### Modification de la structure HTML
On a supprimé les parties dont on avait pas besoin et créé un partial supplémentaire qui contient le formulaire d'inscription à la newsletter.
On l'a ajouté dans le header puis plus bas dans la home page

#### Modification du CSS
On a fait au plus simple : modification du contenu et des images

#### Configuration mailchimp
- On a créé un compte mailchimp
- On a récupéré la clé API et on la insérée dans un fichier .env
- On a récupéré la version 'naked', sans styling, pour l'adapter à notre propre thème bootstrap
- On a testé en enlevant des divs par-ci par-là qui étaient obsolètes (sauf la dernière, important !)
- On l'a intégré dans les views puis on a mis les class bootstrap pour le pimper
- TADAAAA 💌

### La structure de la page
#### Le navigateur
Visible lorsque l'on scrolle, il comporte des liens vers des pages de www.thehackingproject.org
#### Le header
- Le **Call To Action** est visible dès l'arrivée sur la page : le formulaire l'inscription à la newsletter.
- On a choisi de mettre le **moins de texte possible** dans le header pour ne pas perdre l'attention du visiteur, et de mettre les **mots-clés** :
	* 3 mois, gratuit, développeur web, n'importe où
- On a mis une photo de 👶parce que :
	* ça nous faisait marrer
	* tout le monde aime les bébés
	* ça nous semblait pas tant HS
#### Une description de la formation
On insiste sur le fait que la formation soit :
- gratuite
- concrète et pratique
- collaborative
#### Des témoignages pour inspirer confiance
On a repris ceux du site THP, c'est toujours pas mal d'avoir des bonnes têtes qui inspirent confiance.
#### Le CTA pour la newsletter
De nouveau, on remet le CTA pour inciter les gens à s'inscrire à la newsletter. Après avoir lu la super description, comment pourraient-ils faire autrement ? 🤔
#### Les coordonnées de contact
Simple. Basique.

## L'acquisition
### La cible
On a ciblé en priorité :
- les étudiants / jeunes diplômés
- les entrepreneurs

### Les canaux d'acquisition

**Via facebook** :
- on s'est infiltré dans une dizaine de groupes d'étudiants de grandes villes françaises et on a posté le message suivant
> Hello à tous, diplômée depuis un an d'une école de commerce, je suis en train d'apprendre à coder et voulais partager le bon plan avec vous ! 💻
Si t'as l'impression de pas avoir de compétences concrètes pour trouver un taff et tu aimerais rapidement avoir les bases du développement web, mais pas d'argent à dépenser... Regarde The Hacking Project. J'apprends à coder depuis 2 mois gratuitement là-bas, et c'est 👍.
C'est à moitié en ligne / en présentiel et vous pouvez le faire de n'importe où !
Si vous voulez plus d'infos 👉 http://bit.ly/THP75
C'est vraiment une top formation, et plus on sera de fous, mieux ça sera ! 🎈

**Via twitter** :
- on a recyclé notre bon vieux bot twitter des familles :
	* il va chercher 50 tweets qui contiennent le #denotrechoix
	* Il poste 2 messages différents
	* il ne peut pas rerépondre à un tweet
	* il évite les erreurs
- Il tweete le message suivant :
> Salut @#{tweet.user.screen_name}, tu aimerais rapidement avoir les bases du développement web, mais pas d'argent à dépenser ??  
@thehackingproject est fait pour toi ! C'est :
GRATUIT 🎉
sur 3 MOIS 📅
accessible DE N'IMPORTE OÙ 🏝!
Plus d'infos 👉 http://bit.ly/THP75

### Les metrics
#### Le set-up
On a linké notre app à google analytics pour voir nos perfs de malades ! 📈(Non. 📉)

- On a créé un compte google analytics
- on a ajouté le "Global Site Tag" fourni par GG dans le head de la view générée par bootstrap (⚠️ on avait essayé dans la view application... ça ne marche pas)

```<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-113719280-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-113719280-2');
</script>```

- dans l'asset pipeline, on a rajouté dans 'application.js' :
```$(document).on('turbolinks:load', function () {
gtag('config', 'UA-XXXXXXXX-X', {'page_path': window.location.pathname});
});
```
Et voilàààààààà 🎈

#### Les données exploitables
Dans l'hypothèse où on aurait eu beaucoup de trafic, les données les plus pertinentes seraient :
- le taux de rebond
- le taux de clic
- les liens cliqués
- le temps passé sur la page
- le taux de conversion : défini par un objectif qui est l'url de validation du formulaire d'inscription à la newsletter

## Les pistes d'amélioration

### Partie metrics

- Ajouter d'autres landing pages afin de voir via Google analytics quels messages génèrent plus de conversion, et adapter la communication en fonction (ex : si une landing page avec l'argument "vous augmentez votre votre salaire" fonctionne particulièrement bien dans un groupe Facebook d'anciens diplômés, on aurait envoyé son lien à tous les groupes d'alumnis

### Partie acquisition

- faire un bot Messenger qui aurait adressé des messages dans beaucoup plus de groupes Facebook

- tester le scrapping d'emails depuis des sites d'anciens élèves, d'établissements d'enseignement, à utiliser avec la gem Gmail

- utiliser l'API Instagram qui rediffuse les photos du channel Slack #photos pour montrer à quel point THP est plein de gens créatifs

### Partie landing

- améliorer l'ergonomie : fait un flash lorsque quelqu'un rentre son email et redirection sur une cool page

- faire un background avec des images de computer-kid, computer-grandma et computer-lolcat qui défilent

- intégrer le flux live Twitter de Félix
- intégrer un chatbot sur le site qui répond aux demandes avec le même message : "cool, et maintenant inscris-toi à la newsletter"
