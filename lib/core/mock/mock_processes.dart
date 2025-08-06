import 'package:ecomarket/core/models/process.dart';
import 'package:ecomarket/core/mock/mock_customers.dart';
import 'package:ecomarket/core/mock/mock_products.dart';

final List<ProductProcess> mockProcesses = [
  ProductProcess(
    id: 1,
    customer: mockCustomers[0],
    product: mockProducts[0],
    date: DateTime.now().subtract(const Duration(days: 3)),
    status: ProcessStatus.delivered,
    quantity: 3,
  ),

  ProductProcess(
    id: 2,
    customer: mockCustomers[1],
    product: mockProducts[2],
    date: DateTime.now().subtract(const Duration(days: 1)),
    status: ProcessStatus.shipped,
    quantity: 2,
  ),

  ProductProcess(
    id: 3,
    customer: mockCustomers[2],
    product: mockProducts[1],
    date: DateTime.now().subtract(const Duration(days: 7)),
    status: ProcessStatus.cancelled,
    quantity: 5,
  ),

  ProductProcess(
    id: 4,
    customer: mockCustomers[3],
    product: mockProducts[3],
    date: DateTime.now().subtract(const Duration(days: 2)),
    status: ProcessStatus.pending,
    quantity: 1,
  ),

  ProductProcess(
    id: 5,
    customer: mockCustomers[4],
    product: mockProducts[4],
    date: DateTime.now().subtract(const Duration(days: 5)),
    status: ProcessStatus.delivered,
    quantity: 4,
  ),

  ProductProcess(
    id: 6,
    customer: mockCustomers[1],
    product: mockProducts[1],
    date: DateTime.now().subtract(const Duration(days: 10)),
    status: ProcessStatus.delivered,
    quantity: 1,
  ),
  ProductProcess(
    id: 7,
    customer: mockCustomers[0],
    product: mockProducts[2],
    date: DateTime.now().subtract(const Duration(days: 6)),
    status: ProcessStatus.shipped,
    quantity: 3,
  ),
  ProductProcess(
    id: 8,
    customer: mockCustomers[4],
    product: mockProducts[0],
    date: DateTime.now().subtract(const Duration(days: 8)),
    status: ProcessStatus.pending,
    quantity: 2,
  ),
  ProductProcess(
    id: 9,
    customer: mockCustomers[2],
    product: mockProducts[4],
    date: DateTime.now().subtract(const Duration(days: 4)),
    status: ProcessStatus.cancelled,
    quantity: 1,
  ),
  ProductProcess(
    id: 10,
    customer: mockCustomers[3],
    product: mockProducts[0],
    date: DateTime.now().subtract(const Duration(days: 9)),
    status: ProcessStatus.delivered,
    quantity: 5,
  ),
  ProductProcess(
    id: 11,
    customer: mockCustomers[2],
    product: mockProducts[0],
    date: DateTime.now().subtract(const Duration(days: 9)),
    status: ProcessStatus.cancelled,
    quantity: 2,
  ),
  ProductProcess(
    id: 12,
    customer: mockCustomers[3],
    product: mockProducts[3],
    date: DateTime.now().subtract(const Duration(days: 2)),
    status: ProcessStatus.cancelled,
    quantity: 6,
  ),
  ProductProcess(
    id: 13,
    customer: mockCustomers[1],
    product: mockProducts[2],
    date: DateTime.now().subtract(const Duration(days: 1)),
    status: ProcessStatus.delivered,
    quantity: 3,
  ),
];