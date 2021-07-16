import 'package:flutter/material.dart';

class ReviewBoxShort extends StatelessWidget {
  const ReviewBoxShort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
      alignment: AlignmentDirectional.centerStart,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: SizedBox(
                  height: 40,
                  width: 40,
                ),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrange,
                    border: Border.all(color: Colors.white, width: 1)),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "LeBron James",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ratingStartContainer(6)
                ],
              ))
            ],
          ),
          Container(
            child: Text(
              '"Bãi cắm trại đẹp, gần gũi thiên nhiên, có view bờ hồ thơ mộng. Buổi tối được thưởng thức đặc sản cá suối vàng măng rừng. Có tổ chức dạy kỹ năng sinh tồn. Tuyệt vời!!"',
              style: TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            height: 0,
            thickness: 0,
          )
        ],
      ),
    );
  }

  Container ratingStartContainer(int rating) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 2, 5, 0),
              child: Text(
                rating.toStringAsPrecision(2),
                textScaleFactor: 1.2,
              ),
            ),
            Container(
                child: Icon(
              Icons.star_rate,
              size: 20,
              color: Colors.orange,
            )),
            Container(
                child: Icon(
              Icons.star_rate,
              size: 20,
              color: Colors.orange,
            )),
            Container(
                child: Icon(
              Icons.star_rate,
              size: 20,
              color: Colors.orange,
            )),
            Container(
                child: Icon(
              Icons.star_half,
              size: 20,
              color: Colors.orange,
            )),
            Container(
                child: Icon(
              Icons.star_outline,
              size: 20,
              color: Colors.orange,
            ))
          ],
        ),
      );
}
