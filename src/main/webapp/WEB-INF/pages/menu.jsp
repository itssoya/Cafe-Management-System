<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu - Artisan Roast</title>
    <style>
        :root {
            --bg-color: #fcfbf9;
            --text-main: #332b27;
            --text-muted: #7a736e;
            --accent-dark: #332520;
            --btn-bg: #e8e6e1;
            --btn-hover: #d5d3ce;
            --white: #ffffff;
            --light-green: #dcfce7;
            --border-color: #eaeaea;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            padding-bottom: 80px; /* Space for footer */
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        /* --- Filter Navigation --- */
        .filter-nav {
            display: flex;
            gap: 10px;
            margin-bottom: 40px;
        }

        .filter-btn {
            padding: 8px 16px;
            border-radius: 20px;
            border: none;
            background-color: var(--btn-bg);
            color: var(--text-muted);
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-btn.active {
            background-color: var(--accent-dark);
            color: var(--white);
        }

        /* --- Section Headers --- */
        .section-header {
            margin-bottom: 20px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 10px;
        }

        .section-header h2 {
            margin: 0 0 5px 0;
            font-size: 24px;
            font-weight: 700;
        }

        .section-header p {
            margin: 0;
            color: var(--text-muted);
            font-size: 14px;
        }

        .section-header-no-border {
            margin-bottom: 20px;
            margin-top: 40px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-header-no-border .icon-box {
            background-color: var(--light-green);
            padding: 8px;
            border-radius: 8px;
            font-size: 20px;
        }

        /* --- Grids --- */
        .grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 20px;
            margin-bottom: 50px;
        }

        .split-section {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            margin-bottom: 50px;
        }

        /* --- Item Cards (Coffee Classics) --- */
        .item-simple {
            display: flex;
            flex-direction: column;
        }

        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .item-desc {
            color: var(--text-muted);
            font-size: 13px;
            line-height: 1.4;
            flex-grow: 1;
            margin-bottom: 15px;
        }

        .add-btn {
            background-color: var(--btn-bg);
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-weight: bold;
            font-size: 12px;
            cursor: pointer;
            width: 100%;
            text-align: center;
        }

        /* --- Item Cards (Signature Brews) --- */
        .item-card {
            background: var(--white);
            border-radius: 12px;
            padding: 15px;
            display: flex;
            gap: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            align-items: center;
        }

        .item-card img {
            width: 80px;
            height: 80px;
            border-radius: 8px;
            object-fit: cover;
        }

        .item-card-content {
            flex-grow: 1;
        }

        .quick-add {
            font-size: 12px;
            font-weight: bold;
            color: var(--accent-dark);
            text-decoration: none;
            display: inline-block;
            margin-top: 8px;
        }

        /* --- List Items (Teas & Pastries) --- */
        .list-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
            border-bottom: 1px solid var(--border-color);
        }

        .list-item:last-child {
            border-bottom: none;
        }

        .list-item-content h4 {
            margin: 0 0 5px 0;
            font-size: 15px;
        }

        .list-item-content p {
            margin: 0;
            font-size: 12px;
            color: var(--text-muted);
        }

        .circle-btn {
            background: transparent;
            border: 1px solid #ccc;
            border-radius: 50%;
            width: 28px;
            height: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 18px;
            color: var(--text-muted);
        }

        /* --- Footer & Floating Cart --- */
        .footer {
            margin-top: 60px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            color: var(--text-muted);
        }
        .footer-links a {
            color: var(--text-muted);
            text-decoration: none;
            margin-left: 15px;
        }

        .floating-cart {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: var(--accent-dark);
            color: white;
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            cursor: pointer;
        }
        .cart-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: #10b981;
            color: white;
            font-size: 10px;
            font-weight: bold;
            width: 18px;
            height: 18px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid var(--bg-color);
        }

        @media (max-width: 768px) {
            .split-section { grid-template-columns: 1fr; gap: 30px; }
            .grid-2 { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<div class="container">
    
    <div class="filter-nav">
        <button class="filter-btn active">Coffee Classics</button>
        <button class="filter-btn">Signature Brews</button>
        <button class="filter-btn">Teas</button>
        <button class="filter-btn">Pastries</button>
    </div>

    <div class="section-header">
        <h2>Coffee Classics</h2>
        <p>The foundation of our craft, brewed to perfection.</p>
    </div>

    <div class="grid-3">
        <div class="item-simple">
            <div class="item-header">
                <span>House Pour</span>
                <span>$3.75</span>
            </div>
            <p class="item-desc">Our seasonal rotation of ethically sourced beans, brewed in small batches throughout the day.</p>
            <button class="add-btn">+ ADD TO CART</button>
        </div>

        <div class="item-simple">
            <div class="item-header">
                <span>Double Espresso</span>
                <span>$4.25</span>
            </div>
            <p class="item-desc">Two shots of our 'Midnight Roast'. Rich body with notes of dark chocolate and toasted walnut.</p>
            <button class="add-btn">+ ADD TO CART</button>
        </div>

        <div class="item-simple">
            <div class="item-header">
                <span>Cappuccino</span>
                <span>$5.50</span>
            </div>
            <p class="item-desc">Equal parts espresso, steamed milk, and silky micro foam. Served in an 8oz traditional ceramic cup.</p>
            <button class="add-btn">+ ADD TO CART</button>
        </div>
        </div>

    <div class="section-header-no-border">
        <div class="icon-box">✨</div>
        <div>
            <h2 style="margin:0; font-size:22px;">Signature Brews</h2>
            <p style="margin:0; color:var(--text-muted); font-size:14px;">Unique creations by our master baristas.</p>
        </div>
    </div>

    <div class="grid-2">
        <div class="item-card">
            <img src="https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=150&h=150&fit=crop" alt="Smoked Sea Salt Mocha">
            <div class="item-card-content">
                <div class="item-header" style="margin-bottom: 5px;">
                    <span>Smoked Sea Salt Mocha</span>
                    <span>$7.25</span>
                </div>
                <p class="item-desc" style="margin-bottom: 5px;">Artisanal chocolate ganache, double espresso, and a touch of house-smoked Maldon sea salt.</p>
                <a href="#" class="quick-add">Quick Add &rarr;</a>
            </div>
        </div>

        <div class="item-card">
            <img src="https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=150&h=150&fit=crop" alt="Nitro Yuzu Cold Brew">
            <div class="item-card-content">
                <div class="item-header" style="margin-bottom: 5px;">
                    <span>Nitro Yuzu Cold Brew</span>
                    <span>$6.95</span>
                </div>
                <p class="item-desc" style="margin-bottom: 5px;">Velvety nitro cold brew infused with Japanese Yuzu and finished with a rosemary sprig.</p>
                <a href="#" class="quick-add">Quick Add &rarr;</a>
            </div>
        </div>
    </div>

    <div class="split-section">
        <div>
            <h2 style="font-size: 22px; margin-bottom: 20px;">Teas</h2>
            
            <div class="list-item">
                <div class="list-item-content">
                    <h4>Silver Needle White</h4>
                    <p>Grown in Fujian, China. Exceptionally delicate with melon notes.</p>
                </div>
                <div style="font-weight: bold; margin-right: 15px;">$5.50</div>
                <button class="circle-btn">+</button>
            </div>

            <div class="list-item">
                <div class="list-item-content">
                    <h4>Ceremonial Grade Matcha</h4>
                    <p>Whisked by hand. Vibrant, umami-rich, and creamy.</p>
                </div>
                <div style="font-weight: bold; margin-right: 15px;">$6.75</div>
                <button class="circle-btn">+</button>
            </div>
        </div>

        <div>
            <h2 style="font-size: 22px; margin-bottom: 20px;">Pastries</h2>
            
            <div class="list-item">
                <div class="list-item-content">
                    <h4>Brown Butter Croissant</h4>
                    <p>House-made with 48 layers of sourdough pastry and local butter.</p>
                </div>
                <div style="font-weight: bold; margin-right: 15px;">$5.25</div>
                <button class="circle-btn">+</button>
            </div>

            <div class="list-item">
                <div class="list-item-content">
                    <h4>Tahini Miso Cookie</h4>
                    <p>The perfect balance of savory and sweet with white chocolate chips.</p>
                </div>
                <div style="font-weight: bold; margin-right: 15px;">$4.50</div>
                <button class="circle-btn">+</button>
            </div>
        </div>
    </div>

    <div class="footer">
        <div>
            <strong>Artisan Roast</strong><br>
            &copy; <%= java.time.Year.now().getValue() %> Artisan Roast. The Modern Maitre D'.
        </div>
        <div class="footer-links">
            <a href="#">Privacy Policy</a>
            <a href="#">Terms of Service</a>
            <a href="#">Contact Us</a>
        </div>
    </div>

</div>

<div class="floating-cart">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"></path><line x1="3" y1="6" x2="21" y2="6"></line><path d="M16 10a4 4 0 0 1-8 0"></path></svg>
    <div class="cart-badge">2</div>
</div>

</body>
</html>