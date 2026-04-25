document.addEventListener('DOMContentLoaded', () => {
    fetch('/api/auctions')
        .then(response => response.json())
        .then(data => {
            const auctionList = document.getElementById('auctions');
            data.forEach(auction => {
                const li = document.createElement('li');
                li.textContent = `${auction.title} - ${auction.date}`;
                auctionList.appendChild(li);
            });
        })
        .catch(error => console.error('Error fetching auctions:', error));
});