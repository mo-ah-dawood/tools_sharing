// =================== wow script ===================
new WOW().init();

// ==================================================
$(document).ready(function() {
    $(".navbar-nav li").on('click', function() {
        $(".navbar-nav li").removeClass('active');
        $(this).addClass('active');
    });
    // ================== works ===============================

    //========================= get the name of uploaded file=========================
    $('input[type="file"]').change(function() {
        var value = $("input[type='file']").val();
        $('.js-value').text(value);
    });
});



function initReviews() {
    try {
        new Swiper("#reviews", {
            direction: "vertical",
            effect: "coverflow",
            slidesPerView: 1,
            coverflowEffect: {
                rotate: 0,
                stretch: 0,
                depth: 0,
                modifier: 0,
                slideShadows: false
            },
            mousewheelControl: true,
            autoplay: false,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev",
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            on: {
                init: function(swiper) {
                    var active = $("#reviews").find('.swiper-slide-active').eq(0);
                    active.addClass('active');
                    active.prev().prev().addClass('prev_prev');
                    active.prev().addClass('prev');
                    active.next().addClass('next');
                    active.next().next().addClass('next_next');
                },
                slideChangeTransitionStart: function(swiper) {
                    $("#reviews").find('.active').removeClass('active');
                    $("#reviews").find('.prev').removeClass('prev');
                    $("#reviews").find('.next').removeClass('next');
                    $("#reviews").find('.prev_prev').removeClass('prev_prev');
                    $("#reviews").find('.next_next').removeClass('next_next');
                    var active = $("#reviews").find('.swiper-slide-active').eq(0);
                    active.addClass('active');
                    active.prev().prev().addClass('prev_prev');
                    active.prev().addClass('prev');
                    active.next().addClass('next');
                    active.next().next().addClass('next_next');

                },

            },
        });
    } catch (e) {}
}


function initWorksSwiper() {
    try {
        new Swiper("#ourWorks", {
            loop: true,
            centeredSlides: true,
            keyboard: {
                enabled: true,
            },
            autoplay: true,
            breakpoints: {
                0: {
                    slidesPerView: 1,
                },
                768: {
                    slidesPerView: 3,
                },
                1024: {
                    slidesPerView: 5,
                }
            },
            on: {
                init: function(swiper) {
                    var active = $("#ourWorks").find('.swiper-slide-active').eq(0);
                    active.addClass('active');
                    active.prev().prev().addClass('prev_prev');
                    active.prev().addClass('prev');
                    active.next().addClass('next');
                    active.next().next().addClass('next_next');
                },
                slideChangeTransitionStart: function(swiper) {
                    $("#ourWorks").find('.active').removeClass('active');
                    $("#ourWorks").find('.prev').removeClass('prev');
                    $("#ourWorks").find('.next').removeClass('next');
                    $("#ourWorks").find('.prev_prev').removeClass('prev_prev');
                    $("#ourWorks").find('.next_next').removeClass('next_next');
                    var active = $("#ourWorks").find('.swiper-slide-active').eq(0);
                    active.addClass('active');
                    active.prev().prev().addClass('prev_prev');
                    active.prev().addClass('prev');
                    active.next().addClass('next');
                    active.next().next().addClass('next_next');

                },

            },
        });
    } catch (e) {}
}