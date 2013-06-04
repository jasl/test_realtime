//= require jquery
//= require jquery_ujs
//= require jquery.timer
//= require_self

$.timer(function () {
        $.get('users/living')
        $.getJSON('users.json',
            function (data) {
                var online_users = [];
                var anonymous_users = [];
                for (var i in data['online_users']) {
                    online_users.push(i);
                }
                for (var i in data['anonymous_users']) {
                    anonymous_users.push(i);
                }
                $('#online_users').html(online_users.join(', '));
                $('#anonymous_users').html(anonymous_users.join(', '));
            }
        )
    }
    , 2000, true
);
