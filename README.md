
## A-PROPOS
Linsa est un programme qui permet de se connecter automatiquement sur une hôte 
samba sans avoir à retaper ni nom utilisateur ni mots de passe ni addresse de l'hôte.
Le programme cherche elle même les hôtes présente dans la table ARP du client et 
éffectue une teste de connexion sur chaque hôte jusqu'à trouver celui avec les 
les identifiants correspondantes.

Elle possède un option de synchronisation de source et destination différente

## CONFIGURATION

```bash 
nano .env

username=<samba-username>
password=<samba-password>

```
## COMMAND

```bash
./linsa.sh <dossier-share-samba> <dossier-client-source>

```
## Prérequis

- **smbclient** — pour communiquer avec les partages Samba
- **iproute2** — pour récupérer les informations réseau et la table ARP/voisins

### Installation des prérequis

#### Debian / Ubuntu

```bash
sudo apt update
sudo apt install bash smbclient iproute2 
```

#### Fedora

```bash
sudo dnf install bash samba-client iproute 
```
#### Arch-linux

```bash
sudo pacman -S bash smbclient iproute 
```
