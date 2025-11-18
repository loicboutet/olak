# Design System - OLAK Platform

## Overview

This document describes the complete design system for the OLAK property rental platform. All mockups and final implementation must follow these guidelines.

---

## Brand Identity

### Logo

**File Location**: `app/assets/images/logo_olak.png`

**Usage**:
- Primary logo with distinctive circumflex accent: **ôlak**
- Always use official logo file, never recreate manually
- Minimum size: 100px width
- Clear space around logo: minimum 16px

**Color Variants**:
- White background: Use full color logo
- Dark background: Use white version
- Monochrome: Use primary color (#9C8671)

---

## Color Palette

### CSS Variables

Add to `app/assets/stylesheets/application.tailwind.css`:

```css
:root {
  --olak-primary: #9C8671;
  --olak-primary-dark: #7A6656;
  --olak-primary-light: #B89F8E;
  --olak-accent: #D4A574;
  --olak-dark: #2C2C2C;
  --olak-gray: #F5F5F5;
  --olak-white: #FFFFFF;
  --olak-success: #4CAF50;
  --olak-warning: #FF9800;
  --olak-error: #F44336;
}
```

### Tailwind Configuration

Add to `tailwind.config.js`:

```javascript
module.exports = {
  theme: {
    extend: {
      colors: {
        olak: {
          primary: '#9C8671',
          'primary-dark': '#7A6656',
          'primary-light': '#B89F8E',
          accent: '#D4A574',
          dark: '#2C2C2C',
          gray: '#F5F5F5',
          white: '#FFFFFF',
          success: '#4CAF50',
          warning: '#FF9800',
          error: '#F44336',
        }
      }
    }
  }
}
```

### Primary Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Primaire** | `#9C8671` | Boutons principaux, liens, éléments d'action |
| **Primaire Foncé** | `#7A6656` | Titres, textes importants, hover states |
| **Primaire Clair** | `#B89F8E` | Backgrounds légers, sections secondaires |

### Secondary Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Accent** | `#D4A574` | Highlights, badges, call-outs |
| **Texte Principal** | `#2C2C2C` | Corps de texte, contenu principal |
| **Background** | `#F5F5F5` | Fond de page général |
| **Blanc** | `#FFFFFF` | Cards, modales, surfaces blanches |

### Functional Colors

| Color | Hex | Usage |
|-------|-----|-------|
| **Succès** | `#4CAF50` | Validations, confirmations, statuts positifs |
| **Avertissement** | `#FF9800` | Zone tendue, alertes, warnings |
| **Erreur** | `#F44336` | Erreurs, refus, statuts négatifs |

---

## Typography

### Font Family

**Primary Font**: Inter

```css
font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
```

**Installation**: Already included in Rails 8 with `inter-font` stylesheet.

### Typography Scale

| Element | Size | Weight | Line Height | Usage |
|---------|------|--------|-------------|-------|
| **H1** | 48px | 700 (Bold) | 1.2 | Page titles |
| **H2** | 36px | 700 (Bold) | 1.3 | Section titles |
| **H3** | 28px | 600 (Semi-Bold) | 1.4 | Subsection titles |
| **Body** | 16px | 400 (Regular) | 1.6 | Main content |
| **Small** | 14px | 400 (Regular) | 1.5 | Secondary text, captions |

### Tailwind Classes

```html
<!-- H1 -->
<h1 class="text-5xl font-bold text-olak-primary-dark leading-tight">Titre Principal</h1>

<!-- H2 -->
<h2 class="text-4xl font-bold text-olak-primary-dark leading-snug">Titre Secondaire</h2>

<!-- H3 -->
<h3 class="text-3xl font-semibold text-olak-primary-dark leading-normal">Titre Tertiaire</h3>

<!-- Body -->
<p class="text-base text-olak-dark leading-relaxed">Corps de texte</p>

<!-- Small -->
<p class="text-sm text-gray-600 leading-normal">Texte secondaire</p>
```

---

## Buttons

### Primary Button

**Usage**: Main actions, CTAs, form submissions

```html
<button class="bg-olak-primary text-white px-6 py-3 rounded-lg font-semibold 
               transition-all duration-300 hover:bg-olak-primary-dark 
               hover:-translate-y-0.5 hover:shadow-lg">
  Ajouter un bien
</button>
```

**CSS Class** (create in `app/assets/stylesheets/components/buttons.css`):

```css
.btn-primary {
  @apply bg-olak-primary text-white px-6 py-3 rounded-lg font-semibold;
  @apply transition-all duration-300;
  @apply hover:bg-olak-primary-dark hover:-translate-y-0.5;
  @apply hover:shadow-lg;
  @apply border-none cursor-pointer;
}
```

### Secondary Button

**Usage**: Cancel actions, secondary options

```html
<button class="bg-white text-olak-primary px-6 py-3 rounded-lg font-semibold 
               border-2 border-olak-primary transition-all duration-300 
               hover:bg-olak-primary hover:text-white">
  Annuler
</button>
```

**CSS Class**:

```css
.btn-secondary {
  @apply bg-white text-olak-primary px-6 py-3 rounded-lg font-semibold;
  @apply border-2 border-olak-primary;
  @apply transition-all duration-300;
  @apply hover:bg-olak-primary hover:text-white;
  @apply cursor-pointer;
}
```

### Button Sizes

| Size | Padding | Font Size | Class |
|------|---------|-----------|-------|
| **Large** | 12px 24px | 16px | `px-6 py-3 text-base` |
| **Medium** | 10px 20px | 14px | `px-5 py-2.5 text-sm` |
| **Small** | 8px 16px | 12px | `px-4 py-2 text-xs` |

### Disabled State

```html
<button class="btn-primary opacity-50 cursor-not-allowed" disabled>
  Désactivé
</button>
```

---

## Form Elements

### Text Input

```html
<div class="mb-4">
  <label class="block text-sm font-semibold mb-2 text-olak-dark">
    Adresse du bien <span class="text-olak-error">*</span>
  </label>
  <input type="text" 
         class="w-full px-4 py-3 border-2 border-gray-200 rounded-lg text-base
                transition-all duration-300
                focus:outline-none focus:border-olak-primary focus:ring-4 focus:ring-olak-primary/10"
         placeholder="12 rue de la République">
</div>
```

**CSS Class**:

```css
.input-olak {
  @apply w-full px-4 py-3 border-2 border-gray-200 rounded-lg text-base;
  @apply transition-all duration-300;
  @apply focus:outline-none focus:border-olak-primary;
  @apply focus:ring-4 focus:ring-olak-primary/10;
}
```

### Select Dropdown

```html
<select class="input-olak">
  <option>Sélectionnez...</option>
  <option>Appartement</option>
  <option>Maison</option>
  <option>Chambre</option>
</select>
```

### Textarea

```html
<textarea class="input-olak" rows="4" placeholder="Décrivez votre bien..."></textarea>
```

### Checkbox

```html
<label class="flex items-center cursor-pointer">
  <input type="checkbox" 
         class="w-5 h-5 mr-3 accent-olak-primary rounded cursor-pointer">
  <span class="text-sm text-olak-dark">Le bien est situé en zone tendue</span>
</label>
```

### Radio Button (Slash-separated choices)

```html
<div class="space-y-2">
  <label class="flex items-center cursor-pointer">
    <input type="radio" name="rental_type" value="furnished"
           class="w-5 h-5 mr-3 accent-olak-primary cursor-pointer">
    <span class="text-sm text-olak-dark">Meublé</span>
  </label>
  <label class="flex items-center cursor-pointer">
    <input type="radio" name="rental_type" value="unfurnished"
           class="w-5 h-5 mr-3 accent-olak-primary cursor-pointer">
    <span class="text-sm text-olak-dark">Nue</span>
  </label>
</div>
```

### File Upload

```html
<div class="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center
            hover:border-olak-primary transition-all duration-300 cursor-pointer">
  <svg class="mx-auto mb-4 w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
          d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
  </svg>
  <p class="text-sm text-gray-600 mb-2">Glissez votre fichier ici ou cliquez pour sélectionner</p>
  <p class="text-xs text-gray-500">PDF, JPG, PNG - Max 10MB</p>
</div>
```

---

## Cards

### Standard Card

```html
<div class="card-olak">
  <div class="flex justify-between items-start mb-4">
    <h3 class="font-bold text-xl text-olak-primary-dark">Appartement T3</h3>
    <span class="badge badge-success">Disponible</span>
  </div>
  <p class="text-sm text-gray-600 mb-4">75 m² • 2 chambres • Paris 15ème</p>
  <div class="flex items-center justify-between">
    <p class="font-bold text-xl text-olak-primary">1 200 €/mois</p>
    <button class="btn-secondary px-4 py-2 text-sm">Détails</button>
  </div>
</div>
```

**CSS Class**:

```css
.card-olak {
  @apply bg-white rounded-xl p-6;
  @apply shadow-md transition-all duration-300;
  @apply hover:shadow-xl hover:-translate-y-1;
}
```

### Property Card

```html
<div class="card-olak">
  <svg class="house-icon mb-4 text-olak-primary" viewBox="0 0 24 24">
    <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
  </svg>
  <h3 class="font-bold text-lg mb-2 text-olak-primary-dark">Ajoutez votre bien</h3>
  <p class="text-sm text-gray-600 mb-4">Commencez par créer une annonce pour votre propriété</p>
  <button class="btn-primary w-full">Commencer</button>
</div>
```

### Application Card

```html
<div class="card-olak">
  <div class="flex justify-between items-start mb-4">
    <h3 class="font-bold text-xl text-olak-primary-dark">Candidature</h3>
    <span class="badge badge-pending">En attente</span>
  </div>
  <div class="mb-4">
    <p class="font-semibold text-olak-dark">Marie Dupont</p>
    <p class="text-sm text-gray-600">CDI • 2 800 € net/mois</p>
  </div>
  <div class="flex gap-2">
    <button class="btn-primary px-4 py-2 text-sm flex-1">Accepter</button>
    <button class="btn-secondary px-4 py-2 text-sm flex-1">Refuser</button>
  </div>
</div>
```

---

## Navigation

### Top Navbar

```html
<nav class="bg-white shadow-sm">
  <div class="max-w-7xl mx-auto px-6 py-4">
    <div class="flex items-center justify-between">
      <!-- Logo -->
      <img src="/assets/logo_olak.png" alt="OLAK" class="h-10">
      
      <!-- Navigation Links -->
      <div class="flex gap-2">
        <a href="#" class="nav-link active">Tableau de bord</a>
        <a href="#" class="nav-link">Mes biens</a>
        <a href="#" class="nav-link">Candidatures</a>
        <a href="#" class="nav-link">Documents</a>
        <a href="#" class="nav-link">Paiements</a>
      </div>
      
      <!-- User Dropdown -->
      <div class="relative">
        <!-- User menu -->
      </div>
    </div>
  </div>
</nav>
```

**CSS Classes**:

```css
.nav-link {
  @apply text-olak-dark px-4 py-2 rounded-md transition-all duration-300 font-medium;
  @apply hover:bg-olak-gray hover:text-olak-primary;
}

.nav-link.active {
  @apply bg-olak-primary text-white;
}
```

### Breadcrumbs

```html
<nav class="flex mb-6" aria-label="Breadcrumb">
  <ol class="flex items-center space-x-2 text-sm">
    <li>
      <a href="#" class="text-gray-500 hover:text-olak-primary">Accueil</a>
    </li>
    <li>
      <span class="text-gray-400">/</span>
    </li>
    <li>
      <a href="#" class="text-gray-500 hover:text-olak-primary">Mes biens</a>
    </li>
    <li>
      <span class="text-gray-400">/</span>
    </li>
    <li>
      <span class="text-olak-primary font-semibold">Appartement T3</span>
    </li>
  </ol>
</nav>
```

---

## Badges & Status

### Badge Component

```css
.badge {
  @apply px-3 py-1.5 rounded-full text-sm font-semibold inline-block;
}

.badge-success {
  @apply bg-green-100 text-green-800;
}

.badge-pending {
  @apply bg-yellow-100 text-yellow-800;
}

.badge-error {
  @apply bg-red-100 text-red-800;
}

.badge-zone-tendue {
  @apply bg-olak-primary-light text-olak-dark;
}

.badge-furnished {
  @apply bg-blue-100 text-blue-800;
}

.badge-unfurnished {
  @apply bg-purple-100 text-purple-800;
}
```

### Status Usage

| Status | Badge Class | Text | Color |
|--------|-------------|------|-------|
| Validé/Accepté | `badge-success` | Validé | Green |
| En attente | `badge-pending` | En attente | Yellow |
| Refusé/Rejeté | `badge-error` | Refusé | Red |
| Zone tendue | `badge-zone-tendue` | Zone tendue | Primary Light |
| Meublé | `badge-furnished` | Meublé | Blue |
| Nu | `badge-unfurnished` | Nu | Purple |

---

## Form Layouts

### Two-Column Form

```html
<form class="space-y-6">
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div>
      <label class="block text-sm font-semibold mb-2 text-olak-dark">
        Prénom <span class="text-olak-error">*</span>
      </label>
      <input type="text" class="input-olak" placeholder="Jean">
    </div>
    
    <div>
      <label class="block text-sm font-semibold mb-2 text-olak-dark">
        Nom <span class="text-olak-error">*</span>
      </label>
      <input type="text" class="input-olak" placeholder="Dupont">
    </div>
  </div>
  
  <div>
    <label class="block text-sm font-semibold mb-2 text-olak-dark">
      Email <span class="text-olak-error">*</span>
    </label>
    <input type="email" class="input-olak" placeholder="jean.dupont@example.com">
  </div>
  
  <div class="flex gap-4 justify-end">
    <button type="button" class="btn-secondary">Annuler</button>
    <button type="submit" class="btn-primary">Enregistrer</button>
  </div>
</form>
```

### Wizard Form (Multi-step)

```html
<!-- Step Indicator -->
<div class="mb-8">
  <div class="flex items-center justify-between">
    <div class="flex-1 flex items-center">
      <div class="w-10 h-10 rounded-full bg-olak-primary text-white flex items-center justify-center font-bold">1</div>
      <div class="flex-1 h-1 bg-olak-primary mx-2"></div>
    </div>
    <div class="flex-1 flex items-center">
      <div class="w-10 h-10 rounded-full bg-olak-primary-light text-white flex items-center justify-center font-bold">2</div>
      <div class="flex-1 h-1 bg-gray-300 mx-2"></div>
    </div>
    <div class="flex-1 flex items-center">
      <div class="w-10 h-10 rounded-full bg-gray-300 text-gray-600 flex items-center justify-center font-bold">3</div>
    </div>
  </div>
  <div class="flex justify-between mt-2">
    <span class="text-sm font-semibold text-olak-primary">Type de bien</span>
    <span class="text-sm text-gray-600">Détails</span>
    <span class="text-sm text-gray-600">Immeuble</span>
  </div>
</div>

<!-- Form content -->
<div class="card-olak">
  <!-- Form fields -->
</div>

<!-- Navigation -->
<div class="flex justify-between mt-6">
  <button type="button" class="btn-secondary">Retour</button>
  <button type="submit" class="btn-primary">Suivant</button>
</div>
```

---

## Icons

### Icon System

**Library**: Material Design Icons (via SVG)

**Standard Sizes**:
- Inline: 16px
- Standard: 24px
- Large: 32px
- Extra Large: 48px

**Colors**:
- Active/Primary: `text-olak-primary`
- Neutral: `text-gray-600`
- Inactive: `text-gray-400`

### Common Icons

```html
<!-- House/Property -->
<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
  <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
</svg>

<!-- User/Profile -->
<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
  <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
</svg>

<!-- Document -->
<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
  <path d="M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z"/>
</svg>

<!-- Calendar -->
<svg class="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
  <path d="M9 11H7v2h2v-2zm4 0h-2v2h2v-2zm4 0h-2v2h2v-2zm2-7h-1V2h-2v2H8V2H6v2H5c-1.11 0-1.99.9-1.99 2L3 20c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V9h14v11z"/>
</svg>
```

### Icon Usage Principles

1. Use rounded style icons (Material Design)
2. Size: 24px standard, 32px for prominent areas, 16px for inline
3. Color: Primary for actions, Gray for neutral
4. Always accompany with label for accessibility

---

## Spacing System

**Base Unit**: 8px

| Spacing | Value | Tailwind Class | Usage |
|---------|-------|----------------|-------|
| XS | 8px | `p-2`, `m-2` | Minimum space |
| SM | 16px | `p-4`, `m-4` | Between close elements |
| MD | 24px | `p-6`, `m-6` | Card padding, standard spacing |
| LG | 32px | `p-8`, `m-8` | Section spacing |
| XL | 48px | `p-12`, `m-12` | Large separation |

---

## Alerts & Messages

### Success Alert

```html
<div class="bg-green-50 border-l-4 border-green-500 p-4 mb-4 rounded-r-lg">
  <div class="flex items-center">
    <svg class="w-6 h-6 text-green-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
    </svg>
    <p class="text-green-800 font-semibold">Votre bien a été publié avec succès !</p>
  </div>
</div>
```

### Warning Alert

```html
<div class="bg-orange-50 border-l-4 border-orange-500 p-4 mb-4 rounded-r-lg">
  <div class="flex items-center">
    <svg class="w-6 h-6 text-orange-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
    </svg>
    <p class="text-orange-800 font-semibold">Ce bien est situé en zone tendue. Vérifiez le plafond de loyer.</p>
  </div>
</div>
```

### Error Alert

```html
<div class="bg-red-50 border-l-4 border-red-500 p-4 mb-4 rounded-r-lg">
  <div class="flex items-center">
    <svg class="w-6 h-6 text-red-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
    </svg>
    <p class="text-red-800 font-semibold">Veuillez remplir tous les champs obligatoires.</p>
  </div>
</div>
```

### Info Alert

```html
<div class="bg-blue-50 border-l-4 border-blue-500 p-4 mb-4 rounded-r-lg">
  <div class="flex items-center">
    <svg class="w-6 h-6 text-blue-500 mr-3" fill="currentColor" viewBox="0 0 20 20">
      <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
    </svg>
    <p class="text-blue-800 font-semibold">Votre profil nécessite une validation par l'administrateur.</p>
  </div>
</div>
```

---

## Tables

### Standard Table

```html
<div class="overflow-x-auto">
  <table class="min-w-full bg-white rounded-lg overflow-hidden shadow-md">
    <thead class="bg-olak-primary-light text-olak-dark">
      <tr>
        <th class="px-6 py-4 text-left text-sm font-semibold">Propriétaire</th>
        <th class="px-6 py-4 text-left text-sm font-semibold">Bien</th>
        <th class="px-6 py-4 text-left text-sm font-semibold">Statut</th>
        <th class="px-6 py-4 text-left text-sm font-semibold">Actions</th>
      </tr>
    </thead>
    <tbody class="divide-y divide-gray-200">
      <tr class="hover:bg-olak-gray transition-colors">
        <td class="px-6 py-4 text-sm">Jean Dupont</td>
        <td class="px-6 py-4 text-sm">Appartement T3</td>
        <td class="px-6 py-4"><span class="badge badge-success">Validé</span></td>
        <td class="px-6 py-4">
          <button class="text-olak-primary hover:text-olak-primary-dark text-sm font-semibold">Voir</button>
        </td>
      </tr>
    </tbody>
  </table>
</div>
```

---

## Rating Component

### Star Rating Display

```html
<div class="space-y-4">
  <div class="flex items-center justify-between">
    <span class="text-sm font-semibold text-olak-dark">Ratio Salaire/Loyer</span>
    <div class="flex items-center gap-1">
      <!-- 5 stars example -->
      <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
      </svg>
      <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
      </svg>
      <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
      </svg>
      <svg class="w-5 h-5 text-yellow-400" fill="currentColor" viewBox="0 0 20 20">
        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
      </svg>
      <svg class="w-5 h-5 text-gray-300" fill="currentColor" viewBox="0 0 20 20">
        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
      </svg>
      <span class="ml-2 text-sm font-semibold text-olak-dark">4/5</span>
    </div>
  </div>
</div>
```

### Overall Rating Card

```html
<div class="card-olak text-center">
  <div class="text-6xl font-bold text-olak-primary mb-2">4.2</div>
  <p class="text-sm text-gray-600 mb-4">Note globale</p>
  <div class="w-full bg-gray-200 rounded-full h-3 mb-2">
    <div class="bg-olak-primary h-3 rounded-full" style="width: 84%"></div>
  </div>
  <p class="text-xs text-gray-500">Basé sur 5 critères</p>
</div>
```

---

## Modals

### Standard Modal

```html
<div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
  <div class="bg-white rounded-xl shadow-2xl max-w-md w-full mx-4 p-6">
    <div class="flex justify-between items-center mb-4">
      <h3 class="text-2xl font-bold text-olak-primary-dark">Confirmer l'action</h3>
      <button class="text-gray-400 hover:text-gray-600">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
        </svg>
      </button>
    </div>
    
    <p class="text-gray-600 mb-6">Êtes-vous sûr de vouloir accepter cette candidature ?</p>
    
    <div class="flex gap-3">
      <button class="btn-secondary flex-1">Annuler</button>
      <button class="btn-primary flex-1">Confirmer</button>
    </div>
  </div>
</div>
```

---

## Empty States

```html
<div class="text-center py-12">
  <svg class="w-24 h-24 mx-auto mb-4 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
          d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"/>
  </svg>
  <h3 class="text-xl font-semibold text-gray-600 mb-2">Aucun bien pour le moment</h3>
  <p class="text-gray-500 mb-6">Commencez par ajouter votre première propriété</p>
  <button class="btn-primary">Ajouter un bien</button>
</div>
```

---

## Loading States

### Spinner

```html
<div class="flex items-center justify-center py-12">
  <div class="animate-spin rounded-full h-12 w-12 border-4 border-olak-primary-light border-t-olak-primary"></div>
</div>
```

### Skeleton Screen

```html
<div class="card-olak animate-pulse">
  <div class="h-6 bg-gray-200 rounded w-3/4 mb-4"></div>
  <div class="h-4 bg-gray-200 rounded w-1/2 mb-4"></div>
  <div class="h-4 bg-gray-200 rounded w-full mb-2"></div>
  <div class="h-4 bg-gray-200 rounded w-5/6"></div>
</div>
```

---

## Responsive Breakpoints

Follow Tailwind default breakpoints:

| Breakpoint | Min Width | Usage |
|------------|-----------|-------|
| `sm` | 640px | Mobile landscape |
| `md` | 768px | Tablet |
| `lg` | 1024px | Desktop |
| `xl` | 1280px | Large desktop |
| `2xl` | 1536px | Extra large |

### Mobile-First Approach

Always design for mobile first, then enhance for larger screens:

```html
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <!-- Responsive grid -->
</div>
```

---

## Accessibility

### Color Contrast

All text must meet WCAG AA standards:
- Normal text: 4.5:1 contrast ratio minimum
- Large text (18px+): 3:1 contrast ratio minimum

### Focus States

All interactive elements must have visible focus states:

```css
.input-olak:focus,
.btn-primary:focus,
.btn-secondary:focus {
  @apply ring-4 ring-olak-primary/20 outline-none;
}
```

### ARIA Labels

Always include appropriate ARIA labels:

```html
<button aria-label="Fermer le modal" class="...">
  <svg><!-- Close icon --></svg>
</button>
```

---

## Animation Guidelines

### Timing Functions

```css
/* Standard transition */
transition: all 0.3s ease;

/* Hover effects */
transition: transform 0.3s ease, box-shadow 0.3s ease;

/* Loading states */
animation: spin 1s linear infinite;
```

### Principles

1. **Subtle**: Animations should enhance, not distract
2. **Fast**: Keep animations under 300ms for UI feedback
3. **Purposeful**: Every animation should have a reason
4. **Consistent**: Use same timing across similar interactions

---

## Grid System

### Standard Layout Container

```html
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
  <!-- Content -->
</div>
```

### Card Grid

```html
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
  <!-- Cards -->
</div>
```

### Form Grid

```html
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
  <!-- Form fields -->
</div>
```

---

## Implementation Checklist

### CSS Setup
- [ ] Add CSS variables to `application.tailwind.css`
- [ ] Configure Tailwind with OLAK colors
- [ ] Create component classes (buttons, inputs, cards)
- [ ] Import Inter font (already included in Rails 8)

### Assets
- [ ] Add OLAK logo to `app/assets/images/logo_olak.png`
- [ ] Optimize logo for web (PNG with transparency)
- [ ] Create favicon from logo
- [ ] Add logo variants (white, monochrome) if needed

### Components
- [ ] Create button partials
- [ ] Create form input partials
- [ ] Create card partials
- [ ] Create badge partials
- [ ] Create alert partials
- [ ] Create modal partials
- [ ] Create navigation partials
- [ ] Create rating component

### Layouts
- [ ] Update `application.html.erb` with logo
- [ ] Create `mockup_admin.html.erb` with purple accents
- [ ] Create `mockup_owner.html.erb` with blue accents
- [ ] Create `mockup_tenant.html.erb` with green accents

---

## Notes

1. **Consistency**: Always use design system classes, never inline custom colors
2. **Tailwind First**: Leverage Tailwind utility classes before creating custom CSS
3. **Component Reuse**: Extract repeated patterns into partials/components
4. **Design Tokens**: Use CSS variables for all colors (easier to theme/update)
5. **Responsive**: Every component must work on mobile, tablet, and desktop
6. **Accessibility**: Follow WCAG AA standards for contrast and interaction
7. **Performance**: Optimize images, use SVG for icons when possible
8. **Maintainability**: Document any custom CSS or component variations

---

## Resources

- **Tailwind CSS**: https://tailwindcss.com/docs
- **Material Design Icons**: https://fonts.google.com/icons
- **Inter Font**: https://fonts.google.com/specimen/Inter
- **Color Contrast Checker**: https://webaim.org/resources/contrastchecker/

---

## Version

**Design System Version**: 1.0  
**Last Updated**: November 2024  
**Maintainer**: OLAK Development Team
