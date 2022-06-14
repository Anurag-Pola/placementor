import 'package:flutter/material.dart';
import '../models/company_class.dart';

class SearchCompanyTile extends StatelessWidget {
  final Company company;

  const SearchCompanyTile({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            company.offerType == 'On Campus'
                ? '/onCampusCompanyPage'
                : '/offCampusCompanyPage',
            arguments: company);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              child: const FlutterLogo(size: 40),
            ),
            const SizedBox(height: 5),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    company.roleName,
                    style: const TextStyle(
                      color: Color(0xff18191e),
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Opacity(
                  opacity: 0.80,
                  child: Text(
                    company.companyName,
                    style: const TextStyle(
                      color: Color(0xff18191e),
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (company.roleType != null)
                  Chip(
                    name: company.roleType,
                  ),
                if (company.lastDate != null)
                  Chip(
                    name: company.lastDate,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            if (company.package != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: Text(
                    company.package.toString(),
                    style: const TextStyle(
                      color: Color(0xff18191e),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3f000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 2,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
      ),
    );
  }
}

class Chip extends StatelessWidget {
  final String? name;

  const Chip({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xfff4f6fc),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Opacity(
        opacity: 0.80,
        child: Text(
          name ?? "",
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Color(0xff18191e),
            fontSize: 12,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
