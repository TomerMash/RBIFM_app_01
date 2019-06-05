# Reut Buy It For Me

API to fetch data from the Database directly to the app.

### Posts API

> URL: https://reutbuyitforme.com/wp-json/wcra/v1/posts/?secret_key=iPK2yFOSVY9DCkf5F6kQCBOQ2SfMsQcO&count=10
> type: GET

| Params | Value |
| ------ | ------ |
| secret_key | We have to send a key in order to get the posts |
| count | The app 	sends the total posts it has right now. On the first request I have 0 posts so I’ll pass 0, on the second request (scrolling down the table view with posts) I will send 10 as the API returns 10 posts on every request, on the third time I’ll send 20 as I have already got 20 posts. |

The API return a list of objects as follows:

```sh
{
    "status": "OK",
    "response": "Response OK",
    "code": 200,
    "data": [
        {
            "content_link": "LINK TO WEB PAGE",
            "id": 363,
            "title": "איך למדתי גרמנית כדי להוזיל עלויות ב ASOS",
            "date": "15/10/2017",
            "views": "1940",
            "comment_count": "0",
            "author": "רעות תקני לי",
            "category": [
                {
                    "cat_name": "ראשי"
                }
            ],
            "thumbnail": "https://reutbuyitforme.com/wp-content/uploads/2017/10/postHeader_750x350_asosGirlG1.jpg",
            "tags": [
                {
                    "name": "אסוס"
                },
                {
                    "name": "קניות"
                }
            ],
            "content": "&nbsp;\r\n<p style=\"text-align: center;\">פורסם באתר ONLIFE</p>\r\nאתר האופנה הרים \"אינגנים איינקויפן\" :)\r\n\r\n*הכתבה נכתבה ע\"י רעות ופורסמה במקור באתר <span style=\"text-decoration: underline;\"><a href=\"https://www.onlife.co.il/\" target=\"_blank\" rel=\"noopener\">אונלייף</a></span>."
        },
        "375": {
            "id": 375,
            "title": "יש דרך חזרה",
            "date": "17/09/2017",
            "views": "5327",
            "comment_count": "0",
            "author": "רעות תקני לי",
            "category": [
                {
                    "name": "מדריכים",
                }
            ],
            "thumbnail": "https://reutbuyitforme.com/wp-content/uploads/2017/09/postHeader_750x350_hats2_PAYPAL.jpg",
            "tags": [
                {
                    "name": "PAYPAL"
                },
                {
                    "name": "דואר ישראל"
                },
                {
                    "name": "פייפאל"
                },
                {
                    "name": "פייפל"
                },
                {
                    "name": "קניות"
                }
            ],
            "content": "&nbsp;\r\n\r\n<span style=\"font-size: 12pt;\"><strong>קנית כובע בוקרים מהמם והבנת שלא תחבשי אותו לעולם - יש דרך חזרה</strong></span>\r\n\r\nאחד הדברים שהכי מבאסים קוני רשת הוא הפחד שהפריט לא יתאים. שהג'ינס סקיני שנראה מושלם על הדוגמנית יישב פחות סביר על ירכיים ישראליות או שהנעל תהיה רחבה מעבר למידה. רוב האתרים מאפשרים היום החזרה של מוצרים וזיכוי מלא וזה מאוד פשוט. הפריטים מגיעים, נמדדים, לא מתאים, קדימה למעטפה ולדואר חזרה. הזיכוי מגיע בדרך כלל תוך עשרה ימים ואפשר לעבור למוצר הבא.\r\n\r\nלמרות התהליך הפשוט, מצאתי את עצמי הרבה פעמים מתעצלת להחזיר מוצרים. בייחוד באתרים הזולים. הרגשתי מטופש להתעסק בשילוח של מוצר שעלה 50 שקלים ולשלם בערך את אותו סכום שעלה על המשלוח חזרה.  ואז גיליתי את הממתק ש PAYPAL השיקו.\r\n\r\n<img class=\"size-full wp-image-438 aligncenter\" src=\"http://reutbuyitforme.com/wp-content/uploads/2017/09/post_750x_noWayBack_1.jpg\" alt=\"\" width=\"750\" height=\"510\" />\r\n\r\n&nbsp;\r\n\r\nשירות חדש שנקרא \"<span style=\"text-decoration: underline;\"><a href=\"http://bit.ly/2DCWt7b\" target=\"_blank\" rel=\"noopener\">יש דרך חזרה</a></span>\" דרכו תקבלו עד 12 פעמים בשנה זיכוי מלא על המשלוח במידה ושילמתם על המוצרים דרכם.\r\n\r\nלשירות ההחזרה יש להירשם לפני קניית הפריט, כלומר לפני שהגעתם לדואר על מנת לשלוח אותו לאתר.\r\n\r\nמיד אחרי התשלום יש לעלות את חשבונית המשלוח לאתר של PAYPAL  ומייל אישור יגיע אליכם תוך כמה ימים. גאונות בעיני!\r\n*אתם תראו בפרטי התשלום בפייפל שהתווסף לינק להחזר כספי על משלוח חוזר (Request a refund on return shipping)\r\n\r\n<img class=\"size-full wp-image-3462 aligncenter\" src=\"https://reutbuyitforme.com/wp-content/uploads/2017/09/RETURN_PAYPAL1.jpg\" alt=\"\" width=\"800\" height=\"622\" />\r\n\r\n<strong>שימו לב</strong> - השירות עובד רק על חשבונות פרטיים!\r\n\r\nאיך נרשמים לשרות ושאר עניינים - <strong><span style=\"text-decoration: underline;\"><a href=\"http://bit.ly/2DCWt7b\" target=\"_blank\" rel=\"noopener\">לחצו כאן</a></span></strong>\r\n\r\nתהנו\r\n<p dir=\"ltr\"></p>"
        }
    ]
}

```

### Menu API

> URL: https://reutbuyitforme.com/wp-json/wcra/v1/side_menu/?secret_key=iPK2yFOSVY9DCkf5F6kQCBOQ2SfMsQcO&version=1.0.0
> type: GET

| Params | Value |
| ------ | ------ |
| secret_key | We have to send a key in order to get the posts |
| version | The app version so we can control the menu by version |

The API return a list of objects as follows:

```sh
{
    "status": "OK",
    "response": "Response OK",
    "code": 200,
    "data": [
        {
            "name": "Menu field name",
            "icon": "Icon name that the app knows",
            "action": "In case the type is a url, we should see here the url",
            "type": "URL | actoin",
        },
        {
            "name": "המומלצים שלי",
            "icon": "recommended",
            "action": "https://api.reut....",
            "type": "URL",
        },
        {
            "name": "Share",
            "icon": "share",
            "action": "share", // the action is not a URL here. It is the action we decided to perform
            "type": "actoin",
        },
    ]
}

```

