function toggleSidebar() {
    const sidebar = document.getElementById('sidebar');
    if (sidebar.style.width === '250px') {
        sidebar.style.width = '0';
    } else {
        sidebar.style.width = '250px';
    }
}


// Initial call to set the correct view
document.addEventListener('DOMContentLoaded', () => {
    

    // Close sidebar when clicking outside
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const profileButton = document.querySelector('.profilePage');
        
        // Check if the sidebar is open and the click is outside the sidebar and not on the profile button
        if (sidebar.style.width === '250px' && !sidebar.contains(event.target) && !profileButton.contains(event.target)) {
            sidebar.style.width = '0';
        }
    });
});
