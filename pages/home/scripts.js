const updateYears = () => {
    document.getElementById('schemeYears').textContent = 
        ((Date.now() - new Date(1975, 0, 1)) / (1000 * 60 * 60 * 24 * 365.25)).toFixed(16);
};
const randomizeColors = () => {
    document.querySelectorAll('.rotating-lambda').forEach(lambda => {
        lambda.style.color = colors[Math.floor(Math.random() * colors.length)];
    });
};
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('rotating-lambda')) {
        alert('(message "lambda")');
        e.target.style.transform = 'scale(2)';
        setTimeout(() => e.target.style.transform = 'scale(1)', 500);
    } else if (e.target.closest('.retro-text')) {
        alert('СХЕМА ПОБЕДА уже 50 лет');
    }
});
window.addEventListener('load', () => {
    const currentYear = new Date().getFullYear();
    document.querySelectorAll('.current-year').forEach(el => el.textContent = currentYear);
    document.title = `${currentYear} ЭТО ОЧЕРЕДНОЙ ГОД СХЕМА ПОБЕДЫ`;
    updateYears();
    setInterval(updateYears, 100);
    setInterval(randomizeColors, 2000);
});
