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

// 非同期処理のために追加。
//= require jquery
//= require rails-ujs
//= require_tree .