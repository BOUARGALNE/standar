/**
 * Admin Back Office — JavaScript
 *
 * Sidebar toggle, dropdown menus, and UI interactions.
 */

document.addEventListener('DOMContentLoaded', () => {
    // ── Sidebar Toggle (Mobile) ────────────────────────────────────────
    const sidebar = document.getElementById('admin-sidebar');
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const sidebarOverlay = document.getElementById('sidebar-overlay');
    const sidebarClose = document.getElementById('sidebar-close');

    function openSidebar() {
        sidebar?.classList.add('show');
        sidebarOverlay?.classList.remove('hidden');
    }

    function closeSidebar() {
        sidebar?.classList.remove('show');
        sidebarOverlay?.classList.add('hidden');
    }

    sidebarToggle?.addEventListener('click', openSidebar);
    sidebarOverlay?.addEventListener('click', closeSidebar);
    sidebarClose?.addEventListener('click', closeSidebar);

    // Close sidebar on Escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeSidebar();
    });

    // ── User Dropdown ──────────────────────────────────────────────────
    const userDropdownToggle = document.getElementById('user-dropdown-toggle');
    const userDropdown = document.getElementById('user-dropdown');

    userDropdownToggle?.addEventListener('click', (e) => {
        e.stopPropagation();
        userDropdown?.classList.toggle('hidden');
    });

    document.addEventListener('click', () => {
        userDropdown?.classList.add('hidden');
    });

    // ── Auto-dismiss alerts ────────────────────────────────────────────
    const alerts = document.querySelectorAll('.admin-alert[data-auto-dismiss]');
    alerts.forEach((alert) => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            setTimeout(() => alert.remove(), 300);
        }, 4000);
    });

    // ── Confirm dangerous actions ──────────────────────────────────────
    const confirmButtons = document.querySelectorAll('[data-confirm]');
    confirmButtons.forEach((btn) => {
        btn.addEventListener('click', (e) => {
            const message = btn.dataset.confirm || 'Êtes-vous sûr ?';
            if (!confirm(message)) {
                e.preventDefault();
            }
        });
    });
});
