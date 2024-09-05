<h3 align="center">ZonaMedusa</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-green?style=for-the-badge&link=https%3A%2F%2Fwww.lua.org)]()      [![Made in](https://img.shields.io/badge/made%20in-lua-blue?style=for-the-badge&link=https%3A%2F%2Fwww.lua.org)](www.lua.org)      [![License](https://img.shields.io/badge/licence-MIT-black?style=for-the-badge&link=%2FLICENCE)](/LICENSE)

<h5> Made for </h5>

[![Server](https://img.shields.io/badge/Server-FiveM-orange?style=for-the-badge)]() [![GAME](https://img.shields.io/badge/Game-%20GTA%20V%20-darkgreen?style=for-the-badge
)]() [![Framework](https://img.shields.io/badge/Framwork-ESX%20%2F%20ESX%20Legacy-red?style=for-the-badge)]()

</div>

---

<p align="left"> ZonaMedusa és un script para servidores de <b>FiveM (ESX) </b> que permite tener una zona localizada en el mapa donde los jugadores con un <b>banda o trabajo admitido</b> puedan pelear por el control de la zona y sus recompensas. Esta zona se considera como una zona de disputa en la que se avisa a todos los jugadores que se aproximan. 
    <br> 
</p>

## 📝 Contenidos

- [Requisitos](#requisitos)
- [Instalacion](#instalacion)
- [Configuración](#configuracion)
- [Como usar ZonaMedusa](#uso)
- [Built Using](#built_using)
- [Deployment](#deployment)
- [Contributing](../CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 Requisitos <a name = "requisitos"></a>

Antes de instalar el script, asegúrate de tener los siguientes requisitos en tu servidor:

- ESX o ESX Legacy como framework
- Los siguientes scripts instalados:
  - [es_extended](https://github.com/esx-framework/esx_core/tree/main/%5Bcore%5D/es_extended)
  - [esx_banking](https://github.com/esx-framework/esx_banking) o con las mismas funciones
  - [esx_jobs](https://github.com/esx-framework/esx_jobs)

## 🏁 Instalación <a name = "instalacion"></a>

 Sigue los siguientes pasos para instalar correctamente el script en tu servidor, si quieres saber mas puedes mirar las [notas de desarrollo](#desarollo).

#### Clona el repositiorio

Clona el repositorio en tu la carpeta <u> <b> resources</b></u> de tu servidor de FiveM.

```
 git clone https://github.com/ziccur/ZonaMedusa.git
```

Una vez clonado el repositorio, deberás de añadir el script a tu archivo de configuración de recursos <u> <b> server.cfg </b></u> de tu servidor.

```
 ensure ZonaMedusa 
```


<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281058441502130196/undefined_-_Imgur.png?ex=66da5625&is=66d904a5&hm=e7a3e74eea575743587321aa50617f540996054e7d6e5d244de4afd12bdddf83&" alt="server.cfg" width="500"/>

##  🔩 Configuración <a name="configuracion"></a>

Para configurar el script, deberás de modificar el archivo <u> <b> config.lua </b></u> que se encuentra en la carpeta del script. A continuacion una lista de las variables que puedes modificar y su descripción:

- <a >Config.Lenguage </a> = Idioma del script, por defecto es "es" (Español)
- <a >Config.location </a> = Coordenadas de la zona de disputa (x,y,z)
- <a >Config.allowedJobs </a> = Lista de trabajos <b> legales </b> que pueden conquistar la zona de disputa
- <a >Config.allowedIllegalJobs </a> = Lista de trabajos <b> no legales </b> que pueden conquistar la zona de disputa
- <a >Config.NPCspawn </a> = Escoge si quieres que aparezca un NPC en medio de la zona de disputa
- <a >Config.pedModel</a> = Modelo del NPC que aparecerá en la zona de disputa
- <a >Config.conquerKey </a> = Tecla que usaran los jugadores para conquistar la zona de disputa
- <a >Config.Size </a> = Tamaño de la zona de disputa	
- <a >Config.timeToConquer </a> = Tiempo en <b> segundos </b> que se tarda en conquistar la zona
- <a >Config.timeToReward </a> = Frequencia en <b> segundos </b> que se reparten las recompensas
- <a >Config.ilegalReward </a> = Recompensa que se reparte a los trabajos ilegales -> <a >Config.allowedIllegalJobs </a>
- <a >Config.legalReward </a> = Recompensa que se reparte a los trabajos legales -> <a >Config.allowedJobs </a>

- <a >Config.BlipColour </a> = Color del blip de la zona de disputa
- <a >Config.BlipSprite </a> = Sprite del blip de la zona de disputa (dibuo)
- <a >Config.BlipAlpha </a> = Opacidad del blip de la zona de disputa
- <a >Config.defaultOwner </a> = Dueño de la zona de disputa por defecto

## 🎈 Como usar ZonaMedusa <a name="uso"></a>

Desde el lado del jugador aparece en el mapa una zona con un rango que indica el nombre de la zona y quien tiene la posesión de la zona. Así se ve la zona por defecto:

<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281068018147004477/image.png?ex=66da5f10&is=66d90d90&hm=2db43a436e958f35720dc83614899fabf10bddb6e3c4bc6795bfeb2c573cbb19&">

Al entrar y al abandonar de la zona de disputa se te avisará para que sepas que estas en una zona conflictiva 

<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281068771372695603/image.png?ex=66da5fc4&is=66d90e44&hm=50e2549794bac2b0be0592438edfbf4665b0f63ecdf97c53f609e000dc3e76e4&"> <img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281068845578064044/image.png?ex=66da5fd5&is=66d90e55&hm=5a5b2e7a3a973d7424813856cb0fb88e4cc861e6aa17dcf698b542827d41af55&">

Al entrar si estas en un trabajo admitido, podrás conquistar la zona de disputa pulsando la tecla que hayas configurado en el archivo <u> <b> config.lua </b></u>. Si no estás autorizado te aparecerá un mensaje advirtiendote que no puedes conquistar la zona hasta que salgas de la zona.

<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281069564687286322/image.png?ex=66da6081&is=66d90f01&hm=4dc6c862626d4d84e618285f9ddf9ada8a2314a358e1278e92844eb59e0c8f41&">

Al empezar la conquista empezará una cuenta atras en la que deberás mantenerte en la zona para poder completar la conquista. Si sales de la zona la conquista se cancelará y deberás empezar de nuevo.

<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281069977323180215/image.png?ex=66da60e3&is=66d90f63&hm=caac42cd1d165c7ebcbcbae94db55c07791732850349e5278378583d81b4a17d&">

Una vez conquistada la zona, recibirás una recompensa en tu inventario. Si eres un trabajo legal recibirás una recompensa y si eres un trabajo ilegal recibirás otra recompensa. Además, el dueño de la zona de disputa cambiará a tu trabajo.

<img src="https://cdn.discordapp.com/attachments/1234234265437212754/1281070227228200970/image.png?ex=66da611f&is=66d90f9f&hm=3ae5df845c074cd4b039ed5722fe8fec7f9d552812481008c885a6e3bb4b1922&">


Se mantendrá la conquista mientras no se reinicie el script o se reinicie el servidor y mientras nadie conquiste la zona de disputa.


## 🚀 Deployment <a name = "deployment"></a>

Add additional notes about how to deploy this on a live system.

## ⛏️ Built Using <a name = "built_using"></a>

- [MongoDB](https://www.mongodb.com/) - Database
- [Express](https://expressjs.com/) - Server Framework
- [VueJs](https://vuejs.org/) - Web Framework
- [NodeJs](https://nodejs.org/en/) - Server Environment

## ✍️ Authors <a name = "authors"></a>

- [@kylelobo](https://github.com/kylelobo) - Idea & Initial work

See also the list of [contributors](https://github.com/kylelobo/The-Documentation-Compendium/contributors) who participated in this project.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References
