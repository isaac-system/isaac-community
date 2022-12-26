// Set new default font family and font color to mimic Bootstrap's default styling
(Chart.defaults.global.defaultFontFamily = "Metropolis"),
'-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = "#858796";
// Traffic resource

// 프로젝트 상태별 차트
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
    type: "doughnut",
    data: {
        labels: ["요청", "진행", "완료", "피드백"],
        datasets: [{
            data: [45, 30, 15, 10],
            backgroundColor: [
                "rgba(65, 98, 255, 1)",
                "rgba(0, 207, 213, 1)",
                "rgba(0, 172, 105, 1)",
                "rgba(244, 161, 0, 1)"
            ],
            hoverBackgroundColor: [
                "rgba(0, 97, 242, 0.9)",
                "rgba(0, 185, 213, 0.9)",
                "rgba(0, 172, 89, 0.9)",
                "rgba(244, 159, 0, 0.9)"
            ],
            hoverBorderColor: "rgba(234, 236, 244, 1)"
        }]
    },
    options: {
        maintainAspectRatio: false,
        tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: "#dddfeb",
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            caretPadding: 10
        },
        legend: {
            display: false
        },
        cutoutPercentage: 80
    }
});

// 리스크 상태별 차트
var ctx2 = document.getElementById("myRiskChart");
var myRiskChart = new Chart(ctx2, {
    type: "doughnut",
    data: {
        labels: ["병가", "휴가", "개인사유", "기타"],
        datasets: [{
            data: [45, 30, 15, 10],
            backgroundColor: [
                "rgba(227, 0, 89, 1)",
                "rgba(0, 186, 148, 1)",
                "rgba(105, 0, 199, 1)",
                "rgba(247, 100, 0, 1)"
            ],
            hoverBackgroundColor: [
                "rgba(227, 0, 83, 0.9)",
                "rgba(0, 186, 143, 0.9)",
                "rgba(93, 0, 199, 0.9)",
                "rgba(247, 82, 0, 0.9)"
            ],
            hoverBorderColor: "rgba(234, 236, 244, 1)"
        }]
    },
    options: {
        maintainAspectRatio: false,
        tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: "#dddfeb",
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            caretPadding: 10
        },
        legend: {
            display: false
        },
        cutoutPercentage: 80
    }
});

// 인력 현황 차트
var ctx3 = document.getElementById("myManpowerChart");
var myManpowerChart = new Chart(ctx3, {
    type: "pie",
    data: {
        labels: ["배정됨", "배정 안 됨"],
        datasets: [{
            data: [70, 30],
            backgroundColor: [
                "rgba(227, 0, 89, 1)",
                "rgba(224, 224, 224, 1)"
            ],
            hoverBackgroundColor: [
                "rgba(227, 0, 83, 0.9)",
                "rgba(184, 184, 184, 0.9)"
            ],
            hoverBorderColor: "rgba(234, 236, 244, 1)"
        }]
    },
    options: {
        maintainAspectRatio: false,
        tooltips: {
            backgroundColor: "rgb(255,255,255)",
            bodyFontColor: "#858796",
            borderColor: "#dddfeb",
            borderWidth: 1,
            xPadding: 15,
            yPadding: 15,
            displayColors: false,
            caretPadding: 10
        },
        legend: {
            display: false
        },
        cutoutPercentage: 80
    }
});