sommelier :- hypothesize(Thing),
write('You will mostlly like the wine:  '),
write(Thing),
nl,
undo.

hypothesize(agiorgitiko) :- agiorgitiko, !.
hypothesize(aglianico) :- aglianico, !.
hypothesize(airen) :- airen, !.
hypothesize(albarino) :- albarino, !.
hypothesize(alicante_bouschet) :- alicante_bouschet, !.
hypothesize(aligote) :- aligote, !.
hypothesize(arinto) :- arinto, !.
hypothesize(arneis) :- arneis, !.
hypothesize(unknown).

agiorgitiko :- bone_dry,
               medium_full_body,
               medium_high_tannin,
               medium_acidity,
               check_if(has_a_flavour_of_raspberry),
               check_if(has_a_flavour_of_blackberry),
               check_if(has_a_flavour_of_plum_sauce),
               check_if(has_a_flavour_of_black_pepper),
               check_if(has_a_flavour_of_nutmeg).
aglianico :- bone_dry,
             full_body,
             high_tannin,
             medium_high_acidity,
             check_if(has_a_flavour_of_white_pepper),
             check_if(has_a_flavour_of_black_cherry),
             check_if(has_a_flavour_of_smoke),
             check_if(has_a_flavour_of_game),
             check_if(has_a_flavour_of_spiced_plum).
airen :- dry,
         medium_light_body,
         low_acidity,
         check_if(has_a_flavour_of_apple),
         check_if(has_a_flavour_of_pineapple),
         check_if(has_a_flavour_of_grapefruit),
         check_if(has_a_flavour_of_banana),
         check_if(has_a_flavour_of_rose).
albarino :- dry,
            light_body,
            high_acidity,
            check_if(has_a_flavour_of_lemon_zest),
            check_if(has_a_flavour_of_grapefruit),
            check_if(has_a_flavour_of_honeydew),
            check_if(has_a_flavour_of_nectarine),
            check_if(has_a_flavour_of_saline).
alicante_bouschet :- dry,
                     full_body,
                     medium_high_tannin,
                     medium_acidity,
                     check_if(has_a_flavour_of_black_cherry),
                     check_if(has_a_flavour_of_blackberry_bramble),
                     check_if(has_a_flavour_of_black_plum),
                     check_if(has_a_flavour_of_black_pepper),
                     check_if(has_a_flavour_of_sweet_tobacco).
aligote :- bone_dry,
           light_body,
           high_acidity,
           check_if(has_a_flavour_of_apple),
           check_if(has_a_flavour_of_unripe_peach),
           check_if(has_a_flavour_of_white_flower),
           check_if(has_a_flavour_of_smoke),
           check_if(has_a_flavour_of_fresh_herb).
arinto :- bone_dry,
          medium_light_body,
          high_acidity,
          check_if(has_a_flavour_of_lemon_zest),
          check_if(has_a_flavour_of_grapefruit),
          check_if(has_a_flavour_of_hazelnut),
          check_if(has_a_flavour_of_beeswax),
          check_if(has_a_flavour_of_chamomile).
arneis :- bone_dry,
          medium_light_body,
          medium_low_acidity,
          check_if(has_a_flavour_of_peach),
          check_if(has_a_flavour_of_yellow_apple),
          check_if(has_a_flavour_of_honey),
          check_if(has_a_flavour_of_raw_almond),
          check_if(has_a_flavour_of_nutmeg).

tannin :- check_if(is_bitter), !.
tannin :- check_if(is_astringent).

high_tannin :- tannin, !.
high_tannin :- check_if(dries_out_tongue).

medium_tannin :- tannin, !.
medium_tannin :- check_if(tannin_coats_mouth_slowly).

low_tannin :- tannin, !.
low_tannin :- check_if(matches_fruit_or_freshness_taste).

medium_high_tannin :- medium_tannin, !.
medium_high_tannin :- high_tannin.

medium_low_tannin :- medium_tannin, !.
medium_low_tannin :- low_tannin.

acid :- check_if(tastes_fresh), !.
acid :- check_if(is_tart), !.
acid :- check_if(is_zesty).

high_acidity :- acid, !.
high_acidity :- check_if(feels_crisp).

medium_acidity :- acid.

low_acidity :- acid, !.
low_acidity :- check_if(feels_smooth), !.
low_acidity :- check_if(is_soft).

medium_low_acidity :- medium_acidity, !.
medium_low_acidity :- low_acidity.

medium_high_acidity :- medium_acidity, !.
medium_high_acidity :- high_acidity.

full_body :- check_if(has_complex_and_rich_flavor), !.
full_body :- check_if(is_relatively_chewy), !.
full_body :- check_if(is_fat_or_heavy), !.
full_body :- check_if(is_intense), !.
full_body :- check_if(has_over_13_5_percentage_alcohol).

medium_body :- check_if(has_dominant_rich_but_not_complex_flavor), !.
medium_body :- check_if(is_mellow), !.
medium_body :- check_if(is_soft), !.
medium_body :- check_if(is_juicy), !.
medium_body :- check_if(has_betwee_12_5_and_13_5_percentage_alcohol).

light_body :- check_if(is_thin), !.
light_body :- check_if(is_watery), !.
light_body :- check_if(is_wet), !.
light_body :- check_if(has_under_12_5_percentage_alcohol).

medium_full_body :- medium_body, !.
medium_full_body :- full_body.

medium_light_body :- medium_body, !.
medium_light_body :- light_body.

dry :- check_if(has_no_residual_sugar), !.
dry :- medium_acidity.

bone_dry :- dry, !.
bone_dry :- high_tannin, !.
bone_dry :- high_acidity.

off_dry :- check_if(has_some_residual_sugar), !.
off_dry :- medium_low_acidity, !.
off_dry :- medium_tannin.

sweet :- check_if(has_some_residual_sugar), !.
sweet :- check_if(is_aromatic), !.
sweet :- low_acidity, !.
sweet :- low_tannin.

very_sweet :- sweet, !.
very_sweet :- check_if(high_residual_sugar).

ask(Question) :-
write('Does the wine have the following attribute?  '),
write(Question),
write('? '),
read(Response),
nl,
( (Response == yes ; Response == y)
->
assert(yes(Question)) ;
assert(no(Question)), fail).
:- dynamic yes/1,no/1.
check_if(S) :-
(yes(S)
->
true ;
(no(S)
->
fail ;
ask(S))).
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.