// lib/providers/event_provider.dart
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gicc/models/event_model.dart';
import 'package:gicc/services/eventsfirestore_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EventProvider with ChangeNotifier {
  final EventsFirestoreService firestoreService = EventsFirestoreService();
  List<EventModel> _events = [];

  List<EventModel> get events => _events;

  final formKey = GlobalKey<FormState>();
  File? image;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  EventProvider() {
    firestoreService.getEvents().listen((events) {
      _events = events;
      notifyListeners();
    });
  }

  Future<void> addEvent() async {
    if (formKey.currentState!.validate()) {
      String? imageUrl;
      if (image != null) {
        imageUrl = await uploadImage(image!);
      }

      EventModel event = EventModel(
        id: const Uuid().v4(),
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        imageUrl: imageUrl ?? '',
        startDate: startDate!,
        endDate: endDate!,
        startTime: startTime!,
        endTime: endTime!,
      );

      await firestoreService.createEvent(event);
      clearForm();
    }
  }

  Future<void> updateEvent(EventModel existingEvent) async {
    if (formKey.currentState!.validate()) {
      String? imageUrl = existingEvent.imageUrl;
      if (image != null && image!.path != existingEvent.imageUrl) {
        imageUrl = await uploadImage(image!);
      }

      EventModel updatedEvent = EventModel(
        id: existingEvent.id,
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        imageUrl: imageUrl,
        startDate: startDate!,
        endDate: endDate!,
        startTime: startTime!,
        endTime: endTime!,
      );

      await firestoreService.updateEvent(updatedEvent);
      clearForm();
    }
  }

  Future<void> deleteEvent(String eventId) async {
    await firestoreService.deleteEvent(eventId);
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      String fileName = 'events/${const Uuid().v4()}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (e) {
      log("Error uploading image: $e");
      rethrow;
    }
  }

  Future<void> pickDate(BuildContext context,
      {required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null &&
        pickedDate != startDate &&
        pickedDate != endDate) {
      if (isStartDate) {
        startDate = pickedDate;
      } else {
        endDate = pickedDate;
      }
    }
  }

  Future<void> pickTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null &&
        pickedTime != startTime &&
        pickedTime != endTime) {
      if (isStartTime) {
        startTime = pickedTime;
      } else {
        endTime = pickedTime;
      }
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    locationController.clear();
    image = null;
    startDate = null;
    endDate = null;
    startTime = null;
    endTime = null;
  }
}
