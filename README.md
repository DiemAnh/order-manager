# order_manager

A new Flutter project.

## Getting Started
The project focuses on providing a clear and simple interface for managing restaurant operations such as order tracking, kitchen preparation, payment management, and report exportation.

## Features

### Order Management
- Create and manage orders based on tables.
- Add and delet multiple food items to an order.
- Track the status of each item in the order.
- Support different order statuses including:
  - Pending
  - Cooking
  - Finished
  - Served
  - Paid
  - Cancelled
  - Paid

### Kitchen Preparation
- Make the dishes as ordered.
- Cancel the order.

### Table Payment Overview
- Display tables currently being served.
- Calculate the number of returned dishes per table.
- Calculate the total payment for each table.
- Provide an overview of total pending revenue.

### Order Statistics
- Show total number of orders.
- Show orders currently being served.
- Show completed (paid), cancelled orders.

### Export Order Report
- Export all order data to a text file (.txt).
- The report includes:
  - Order ID
  - Table number
  - Food items
  - Quantity
  - Order status
  - Total price per item

### Recent Orders Tracking
- Display recent orders with their status.
- Show the number of items in each order.
- Display the order creation time.

## Technologies Used

- Flutter
- Dart
- ValueNotifier / ValueListenableBuilder for state management
- path_provider for file system access
- share_plus for sharing exported files

## Project Structure

The project is organized into multiple layers:

- data  
  Contains models, enums, and data stores.

- presentations  
  Contains UI pages and widgets used in the application.

- features  
  Different application features such as order management, export, and payment.

## Purpose

This project was created to demonstrate a basic restaurant order management workflow using Flutter. It focuses on managing order states, calculating totals, and exporting reports while maintaining a clean and simple user interface.

## Detail Screens


This project contains 4 pages: Order Page, Kitchen Page, Payment Page and Export Page

<img width="120" height="262" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-17 at 01 34 42" src="https://github.com/user-attachments/assets/8d3b18f0-4857-44d8-bbc7-175daa43d1f1" />

<img width="120" height="262" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-17 at 01 34 52" src="https://github.com/user-attachments/assets/b8f0f212-70ed-4fe2-bd65-ec405d713e1a" />

<img width="120" height="262" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-17 at 01 34 58" src="https://github.com/user-attachments/assets/a94f4883-a10d-4c96-aa0a-419170464e1e" />

<img width="120" height="262" alt="Simulator Screenshot - iPhone 17 Pro - 2026-03-17 at 01 35 16" src="https://github.com/user-attachments/assets/5fd5a901-75e3-4f5b-b5f7-9826db9fc780" />
