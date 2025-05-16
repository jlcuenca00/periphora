# Periphora - E-commerce UI Project 🎧🖱️⌨️

**Student Name:** Jake Kevin Klair L. Cuenca

**Student ID:** 2023-2110305

---

## Project Description 🛍️

Periphora is a modern e-commerce mobile app specialized in tech peripherals — from gaming mice 🎮 and mechanical keyboards ⌨️ to audio headsets 🎧. The app offers an immersive shopping experience with a sleek dark theme, smooth animations, and interactive UI components. It’s designed for tech enthusiasts who want a stylish and user-friendly platform to browse and buy high-quality gadgets.

---

## Implemented Features ✅

### Screens

- **Home Screen 🏠**  
  Features a horizontally scrollable animated parallax carousel for products, personalized greeting 👋, dynamic filter tags 🎯, and a "Recently Viewed" section 🔄.

- **Product Detail Screen 🛒**  
  Pinch-zoomable images 🔍, animated color selectors 🎨, and a reusable quantity selector widget with sticky “Add to Cart” button 🛍️.

- **Cart Screen 🛒**  
  Swipe-to-delete items 🗑️, animated quantity controls, clear pricing summary 💰, and “Proceed to Checkout” button.

- **Checkout Screen 💳**  
  Form inputs for shipping and payment info with animated payment cards 💳 and validation.

- **Order Confirmation Screen ✅**  
  Displays order success message, order number, and navigation buttons.

- **Splash Screen ⏳**  
  Fade-in logo with progress bar for a smooth app startup.

- **Main Navigation 📱**  
  Bottom navigation bar for easy switching between Home, Cart, and Profile.

- **Profile Screen 👤**  
  User avatar, personal info, and quick access to orders, settings, and logout.

---

### Additional UI Features ✨

- Animated parallax product cards for depth perception  
- Reusable, animated quantity selector widget  
- Interactive color selectors with smooth highlights  
- Swipe-to-delete gestures for cart items  
- Custom brand logo with gradient text and icon  
- Subtle animations on button presses and screen transitions

---

## Unique Design Choices & Creativity 🎨

### Niche & Influence 🎯

Targeting tech enthusiasts and gamers, the design blends sophistication with comfort through a dark theme and modern UI patterns.

### Color Palette 🎨

- **Primary:** Dark Purple (#7F5AF0) — vibrant yet professional  
- **Background:** Deep Charcoal (#121212) — eye-friendly and stylish  
- **Accent & Surface:** Shades of purple and gray for depth  
- **Text:** Whites and muted whites for clarity and hierarchy

### Typography & Iconography ✍️

- **Fonts:** Poppins for headlines (bold, modern), Roboto for body (clean, readable)  
- **Icons:** Consistent material icons for clarity

### Innovative UI/UX Features 💡

- Parallax effects on product carousel for immersive browsing  
- Reusable widgets for consistency & maintainability  
- Interactive elements like pinch-zoom and animated selectors  
- Personalized touches like “Welcome back” message and “Recently Viewed”

## Challenges Faced & Solutions 🛠️

### Challenge 1: Smooth Parallax Animation

- **Issue:** Creating natural card scaling and movement on horizontal scroll was tricky.  
- **Solution:** Used `PageController.page` to track scroll position and scale cards; added subtle image movement inside cards for layered parallax.

### Challenge 2: Consistent Quantity Control

- **Issue:** Multiple quantity controls caused inconsistent UI and complex state handling.  
- **Solution:** Built a reusable `QuantitySelector` widget used across Product Detail and Cart screens, simplifying state management and UX.

---
