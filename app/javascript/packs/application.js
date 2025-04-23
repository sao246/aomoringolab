// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// Bootstrap用に追記 2025/4/6
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Chart.jsをインポート trendビューに表描画をするために設定。2025/04/23
import Chart from 'chart.js/auto';

// trendビューへの表描画用
// 
document.addEventListener('turbolinks:load', () => {
  const raw = document.getElementById('chart-data');
  if (!raw) return;

  const { labels, data, ids } = JSON.parse(raw.textContent);
  const ctx = document.getElementById('trendChart');

  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        label: 'いいね数',
        data: data,
        backgroundColor: 'rgba(255, 99, 132, 0.5)',
        borderColor: 'rgba(255, 99, 132, 1)',
        borderWidth: 1
      }]
    },
    options: {
      onClick: (e, elements) => {
        if (elements.length > 0) {
          const index = elements[0].index;
          window.location.href = `/posts/${ids[index]}`;
        }
      },
      plugins: {
        tooltip: {
          callbacks: {
            label: function(context) {
              return `${context.label}：${context.raw}件`;
            }
          }
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          title: {
            display: true,
            text: 'いいね数'
          }
        }
      }
    }
  });
});

