// ignore_for_file: file_names, avoid_print
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showInternetPopup() {
  return  AlertDialog(
          elevation: 0.1,
          content: SizedBox(
            height: double.infinity/9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Retry"),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity/20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [const Color(0xFFFEF400).withOpacity(0.7), const Color(0xFFEC3237).withOpacity(0.7)]),
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                        ),
                        child: InkWell(
                          onTap: () {
                            print('yes selected');
                            // exit(0);
                          },
                          child: const Center(child: Text(
                            "internet Not Connected",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],
                )
              ],
            ),
          ),
        );
}