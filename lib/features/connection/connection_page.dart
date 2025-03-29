import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'connection_cubit.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Connection Status')),
      body: Center(
        child: BlocBuilder<ConnectionCubit, ConnectionStatus>(
          builder: (context, state) {
            if (state is ConnectionInitial) {
              return _buildInitialState(context);
            } else if (state is ConnectionLoading) {
              return _buildLoadingState();
            } else if (state is ConnectionSuccess) {
              return _buildConnectedState();
            } else if (state is ConnectionFailure) {
              return _buildDisconnectedState(context);
            } else {
              return const Text('Unknown state');
            }
          },
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Checking connection status...',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            context.read<ConnectionCubit>().checkConnection();
          },
          child: const Text('Check Connection'),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text('Checking your connection...', style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildConnectedState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi, size: 80, color: Colors.green),
        const SizedBox(height: 20),
        const Text(
          'Connected',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'You are connected to the internet',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.check_circle, color: Colors.green),
          label: const Text(
            'Internet Available',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _buildDisconnectedState(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.wifi_off, size: 80, color: Colors.red),
        const SizedBox(height: 20),
        const Text(
          'Disconnected',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'No internet connection available',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 30),
        ElevatedButton.icon(
          onPressed: () {
            context.read<ConnectionCubit>().checkConnection();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Retry'),
        ),
      ],
    );
  }
}
