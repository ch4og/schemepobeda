const randomizeColors = () => {
    document.querySelector('.rotating-lambda').style.color = 
        colors[Math.floor(Math.random() * colors.length)];
};
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('rotating-lambda')) {
        alert('(error "Лямбда не может найти страницу!")');
        e.target.style.transform = 'scale(1.5)';
        setTimeout(() => e.target.style.transform = 'scale(1)', 500);
    }
});
setInterval(randomizeColors, 1500);
