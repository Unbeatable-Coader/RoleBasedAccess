document.addEventListener('DOMContentLoaded', function() {
  // Your existing JavaScript code here

  function changeColor(cardId, color, status) {
    let card = document.getElementById(cardId);
    if (card) {
      card.style.backgroundColor = color;

      // Update the status in localStorage
      localStorage.setItem("taskStatus_#{cardId}", status);
    }
  }

  // Set the initial colors based on stored status
  document.querySelectorAll('.task-card').forEach(function(card) {
    let cardId = card.id;
    let storedStatus = localStorage.getItem("taskStatus_#{cardId}");

    if (storedStatus === 'Pending') {
      card.style.backgroundColor = 'lightcoral';
    } else if (storedStatus === 'Mark as Done') {
      card.style.backgroundColor = 'lightgreen';
    }
  });
});

