# Ajouter un bien

## Organigramme du processus d'ajout de bien

```
Ajouter un bien
    |
    ├── Appartement ──→ Appartement ──→ Immeuble
    |
    ├── Chambre ──→ Appartement ──→ Chambre ──→ Immeuble
    |           └── Maison ──→ Chambre
    |
    └── Maison ──→ Maison
```

Ce diagramme montre les différentes options disponibles lors de l'ajout d'un bien :

1. **Appartement** : Mène à une page "Appartement" puis à "Immeuble"
2. **Chambre** : Offre deux chemins :
   - Via "Appartement" vers "Chambre" puis "Immeuble"
   - Via "Maison" vers "Chambre"
3. **Maison** : Mène directement à une page "Maison"
