# 🌱 Le Potager — Devinci Durable

An interactive 3D garden viewer built with **Three.js** for the *Devinci Durable* association. Explore, plant, and harvest vegetables in a virtual garden modelled after the real campus potager at Pôle Léonard de Vinci.

---

## 🚀 Running the Project

```bash
npx serve .
```

Then open the local URL displayed in your terminal (e.g. `http://localhost:3000`).

---

## 🗺️ Site Features

### 3D Garden Scene

- A full 3D model of the potager (`potager.glb`) is loaded and displayed using **Three.js**.
- The camera starts at an overview angle, looking down at the entire garden.
- Smooth **orbit, pan and zoom** controls via mouse or touch gestures (powered by `OrbitControls`).
- **Hover highlighting**: hovering over a garden bed outlines it in dark blue to hint it is interactive.

---

### 🥦 Garden Beds (Bacs)

The garden contains **9 clickable garden beds**, each with metadata:

| Hitbox | Name |
|--------|------|
| HitBox_1 | Carré de Tomates |
| HitBox_2 | Carré de Salades |
| HitBox_3 | Carré de Carottes |
| HitBox_4 | Carré de Radis | (Place Holder names)
| HitBox_12 | Zone Plate | Flat ground area (y=0) |

**Clicking or tapping** a bed:
- Animates the camera to zoom in on the chosen bed.
- Shows an **Interaction Panel** with available actions.
- A **← Retour** button appears to go back to the overview.

---

### 📋 Interaction Panel

When a bed is selected, a panel appears (bottom-right on desktop, bottom sheet on mobile) with three actions:

#### 📖 Informations
Displays the bed's name and cultivation notes (variety, planting and harvest season).

#### 🧺 Récolter (Harvest Mode)
- **Toggles Harvest Mode** on/off.
- The panel border turns red to indicate the mode is active.
- Each plant gets an **invisible hitbox** slightly larger than itself — much easier to click than the raw 3D geometry.
- **Hover**: a red wireframe outline appears around the hovered plant.
- **Click / Tap**: the targeted plant shrinks and disappears with a smooth animation.
- Selecting **Planter** automatically exits Harvest Mode.

#### 🌱 Planter (Plant Mode)
Opens the **Plant Selection Modal**.

---

### 🌿 Planting Modal

A scrollable grid of available plants to add to the selected bed. Each card shows an emoji icon, name, and short description.

**Available plants:**

| Plant | Model | Notes |
|-------|-------|-------|
| Radis | `plant_radish.glb` | Small scale (0.13) |
| Tomate | `plant_tomato.glb` | Full size |
| Laitue | `lettuce_plant.glb` | Scale 0.3 |
| Épinards | `sprout1.glb` | |
| Basilic | `sprout1.glb` | |
| Ail | `garlic_plant.glb` | Scale 0.3 |
| Oignon | `onion_plant.glb` | Scale 0.3 |
| Persil | `parsley_plant.glb` | Rotated 90° on X-axis |
| Fèves | `broad_bean_plant.glb` | |
| Plante Verte | `plant1.glb` | |
| Grande Plante | `big_plant.glb` | |
| Plante Moyenne | `medium_plant.glb` | |
| Petite Plante | `small_plant.glb` | |

Selecting a plant:
- Closes the modal.
- Minimizes the interaction panel automatically (mobile UX).
- Shows an instruction: *"Cliquez dans le bac pour planter : [Name]"*.
- **Click or tap anywhere on the bed soil surface** to plant. Plants are placed on the actual soil surface using a secondary downward raycast (snap-to-soil).
- Multiple plants of the same type can be placed in succession.
- Each planted instance grows from nothing with a **spring animation** (GSAP `back.out`).

---

### ⚡ Performance — GPU Instancing

Plants use **Three.js `InstancedMesh`** for high performance:

- GLTF model data is **pre-fetched once** at startup.
- `InstancedMesh` GPU objects are created **lazily** only when a plant type is first planted.
- Up to **100 instances per plant type** are supported.
- Each sub-mesh in a GLTF file gets its own `InstancedMesh`, preserving materials.
- **Per-plant base rotations** (`xRotation`, `yRotation`, `zRotation`) can be configured per plant type to fix model orientation.

---

### 📱 Mobile Support

- Fully responsive: layout adapts below **600px** width.
- The **Interaction Panel** becomes a bottom sheet (full width, rounded top corners, drag handle).
- The panel **auto-folds** when planting or harvesting to maximize the view.
- A **chevron button** lets the user manually expand/collapse the panel at any time.
- Touch events are handled separately for bed selection, planting, and harvesting.
- Drag detection prevents accidental selections after panning.

---

### 🗂️ Sidebar Navigation

A collapsible sidebar with two sections:

- **Le Potager 3D** — returns to the main 3D view.
- **À Propos** — slides in an info panel about the Devinci Durable association, with links to Instagram and email.

---

### ⏳ Loading Screen

A full-screen loading screen is shown while the potager and all plant GLTF models load, with:
- An animated pulsing logo.
- A progress bar tracking the main garden model download.

---

## 📁 Project Structure

```
potager_web/
├── index.html          # Entire application (HTML + CSS + JS)
├── README.md           # This file
└── 3dModels/
    ├── potager.glb     # Main garden scene with HitBox meshes
    └── plants/
        ├── plant_radish.glb
        ├── plant_tomato.glb
        ├── lettuce_plant.glb
        ├── garlic_plant.glb
        ├── onion_plant.glb
        ├── parsley_plant.glb
        ├── broad_bean_plant.glb
        ├── sprout1.glb
        ├── plant1.glb
        ├── big_plant.glb
        ├── medium_plant.glb
        ├── small_plant.glb
        └── ...
```

---

## 🛠️ Tech Stack

| Library | Version | Role |
|---------|---------|------|
| [Three.js](https://threejs.org/) | 0.160.0 | 3D rendering |
| [OrbitControls](https://threejs.org/docs/#examples/en/controls/OrbitControls) | 0.160.0 | Camera navigation |
| [GLTFLoader + DRACOLoader](https://threejs.org/docs/) | 0.160.0 | 3D model loading |
| [GSAP](https://gsap.com/) | CDN (Skypack) | Animations |
| [Google Fonts — Outfit](https://fonts.google.com/specimen/Outfit) | — | Typography |

---

## 👥 About

Built for **Devinci Durable**, the sustainability association of Pôle Léonard de Vinci.  
📸 [Instagram](https://www.instagram.com/devinci_durable/)  
📧 [devincidurable@devinci.fr](mailto:devincidurable@devinci.fr)
