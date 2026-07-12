"use strict";
const root = document.documentElement;
const cycle = ['auto', 'light', 'dark'];
function applyTheme(theme) {
    if (theme === 'auto') {
        root.removeAttribute('data-theme');
        localStorage.removeItem('theme');
    }
    else {
        root.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
    }
}
function toggleTheme() {
    var _a;
    const current = ((_a = root.getAttribute('data-theme')) !== null && _a !== void 0 ? _a : 'auto');
    applyTheme(cycle[(cycle.indexOf(current) + 1) % cycle.length]);
}
// Runs immediately in <head> — only touches <html>, no DOM needed
const saved = localStorage.getItem('theme');
if (saved)
    applyTheme(saved);
document.addEventListener('DOMContentLoaded', () => {
    document.querySelector('.theme-toggle')
        .addEventListener('click', toggleTheme);
});
