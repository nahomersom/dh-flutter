import 'package:dh/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/cutom_text.dart';

class DevicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const CustomText(
          title: "Devices",
          fontSize: AppConstants.xLarge,
          textColor: Colors.black,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppConstants.grey700,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: AppConstants.smallMargin,
            vertical: AppConstants.mediumMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDeviceCard(),
            // const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Active sessions',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryColor),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSessionCard(
                    'Microsoft Edge 127',
                    'DH Web 2.1.0 K',
                    'Addis Ababa, Ethiopia • 8:02 PM',
                  ),
                  const Divider(),
                  _buildSessionCard(
                    'HP EliteBook 840 G6',
                    'DH Desktop 5.2.3 x64 Microsoft Store',
                    'Addis Ababa, Ethiopia • Sun',
                  ),
                  const Divider(),
                  _buildSessionCard(
                    'HP Laptop 17-cn0xxx',
                    'DH Desktop 5.1.7 x64',
                    'Addis Ababa, Ethiopia • Fri',
                  ),
                  const Divider(),
                  _buildSessionCard(
                    'Microsoft Edge 126',
                    'DH Web 2.1.0 K',
                    'Addis Ababa, Ethiopia • Thu',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.laptop,
              size: 100,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Link DH Desktop or DH Web by scanning a QR code.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppConstants.grey500),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.qr_code),
              label: const Text('Link Desktop Device'),
              style: ElevatedButton.styleFrom(
                // primary: Colors.blue,
                backgroundColor: AppConstants.primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey[700]),
          const SizedBox(height: 10),
          const Text(
            'This device',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppConstants.primaryColor),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppConstants.primaryColorLight.withOpacity(.3),
                      shape: BoxShape.circle),
                  child:
                      const Icon(Icons.android, color: Colors.green, size: 40)),
              const SizedBox(
                width: 25,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Samsung Galaxy A10',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Text('DH Android 10.15.1\nAddis Ababa, Ethiopia • online',
                      style: TextStyle(color: AppConstants.grey500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(
                Icons.back_hand_outlined,
                color: Colors.red,
              ),
              SizedBox(
                width: 25,
              ),
              CustomText(
                title: "Terminate All Other Sessions",
                fontSize: AppConstants.medium,
                fontWeight: FontWeight.bold,
                textColor: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[700]),
        ],
      ),
    );
  }

  Widget _buildSessionCard(String deviceName, String version, String location) {
    return ListTile(
      leading: const Icon(Icons.device_hub, color: Colors.blue, size: 40),
      title: Text(deviceName, style: const TextStyle(color: Colors.white)),
      subtitle: Text('$version\n$location',
          style: const TextStyle(color: AppConstants.grey500)),
    );
  }
}
