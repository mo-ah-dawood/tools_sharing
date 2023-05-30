var firebaseConfig = {
    apiKey: "AIzaSyDwSaSqXvTjcIS9k4NoNB22EQKkPiTZJM4",
    authDomain: "new-step-af9de.firebaseapp.com",
    projectId: "new-step-af9de",
    storageBucket: "new-step-af9de.appspot.com",
    messagingSenderId: "421513394339",
    appId: "1:421513394339:web:f5d08ddf63868065a0e716",
    measurementId: "G-QDME5ZMR30"
};
firebase.initializeApp(firebaseConfig);
var analytics = firebase.analytics();
var db = firebase.firestore();

function renderSection(data, section) {
    try {
        var template = $.templates(`#${section}_template`);
        var htmlOutput = template.render(data);
        $(`#${section}`).html(htmlOutput);
    } catch (error) {

    }
}

var helpers = {
    addToFireStore: (doc, data) => {
        return doc.set(data, { merge: true }).catch((error) => {
            db.collection("messages_fails").add({
                "error": error.toString(),
                "data": data,
            });
        });
    },
    sendMessage: (event, args) => {
        analytics.logEvent('contact_subbmitted', contact);
        var email = args.view.data["email"];
        var user_name = args.view.data["user_name"];
        var user_email = args.view.data["user_email"];
        var user_message = args.view.data["user_message"];
        var doc = db.collection("messages").doc(user_email);
        event.preventDefault();
        $.observable(args.view.data).setProperty('loading', true);
        helpers.addToFireStore(doc, {
            "messages": firebase.firestore.FieldValue.arrayUnion({
                "user_name": user_name,
                "user_message": user_message,
                "user_email": user_email,
                "date": new Date(),
            }),
            "last_send": new Date(),
            "count": firebase.firestore.FieldValue.increment(1)
        }).then(() => {

            $.observable(args.view.data).setProperty('loading', false);
            Swal.fire({
                titleText: 'تم الإرسال',
                message: 'شكرا لتواصلك معنا سيتم الإتصال بك في أقرب وقت ممكن',
                icon: 'success',
                confirmButtonText: 'إغلاق',
                timer: 5000,
                timerProgressBar: true,
            }).then((result) => {
                window.location.href = "/";
            })

        }).catch((e) => {
            $.observable(args.view.data).setProperty('loading', false);
            Swal.fire({
                title: 'فشلت العملية',
                message: 'عذرا! حدث خطأ ما \n مازال بإمكانك إرسال الرسالة عبر البريد الإلكتروني',
                icon: 'error',
                confirmButtonText: 'إرسال',
                denyButtonText: `إغلاق`,
                timer: 5000,
                timerProgressBar: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    var w = window.open(`mailto:${email}?subject=${user_name}&body=${user_message}`);
                    w.onclose = () => {
                        window.location.href = "/";
                    };
                } else
                    window.location.href = "/";
            })

        });

    },
};

function linkSection(data, section) {
    try {
        var template = $.templates(`#${section}_template`);
        template.link(`#${section}`, data, helpers);
    } catch (error) {

    }
}
var filledSent = false;
db.collection("settings")
    .onSnapshot((snapShot) => {
        var data = {};
        snapShot.forEach((doc) => {
            data[doc.id] = doc.data();
        });

        renderSection(data["header"], "header");
        renderSection(data["services"], "services");
        renderSection(data["about"], "about");
        renderSection(data["our_works"], "works");
        setTimeout(initWorksSwiper, 500);
        renderSection(data["reviews"], "testimonial");
        setTimeout(initReviews, 500);
        renderSection(data["footer"], "footer");
        var contact = data['contact'];
        contact['disabled'] = true;
        linkSection(contact, "contact");
        $(document).on('click', 'a', function(e) {

            try {
                var url = new URL($(this).attr('href')); {
                    if (isNotEmpty(url.hostname))
                        analytics.logEvent(url.hostname, {
                            "url": $(this).attr('href'),
                            "date": new Date()
                        });
                }
            } catch (e) {}
        });
        if ($.observable)
            $.observable(contact).observeAll((ev, args) => {
                var canContact = !(isNotEmpty(contact['user_name']) && isNotEmpty(contact['user_email']) && isNotEmpty(contact['user_message']));
                if (canContact && !filledSent) {
                    filledSent = true;
                    analytics.logEvent('contact_filled', contact);
                }
                $.observable(contact).setProperty('disabled', contact["loading"] === true || canContact);
            });

    });

function isNotEmpty(value) {
    return typeof value == 'string' && value.length > 0;
}