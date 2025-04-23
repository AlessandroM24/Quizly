<?php

namespace App\Controllers;

use App\Models\UtenteModel;

class LoginController extends BaseController
{
    public function index()
    {
        return view('login');
    }

    public function auth()
    {
        $session = session();
        $model = new UtenteModel();

        $username = $this->request->getPost('username');
        $password = $this->request->getPost('password');

        $utente = $model->where('username', $username)->first();

        if ($utente) {
            if ($password === $utente['password']) {
                $sessionData = [
                    'id'       => $utente['id_utente'],
                    'username' => $utente['username'],
                    'ruolo'    => $utente['ruolo'],
                    'logged_in' => true,
                ];
                $session->set($sessionData);

                // Redirect in base al ruolo
                if ($utente['ruolo'] === 'docente') {
                    return redirect()->to('/docente/dashboard');
                } elseif ($utente['ruolo'] === 'studente') {
                    return redirect()->to('/studente/dashboard');
                } else {
                    return redirect()->to('/admin/dashboard');
                }
            } else {
                return redirect()->to('/login')->with('error', 'Password errata');
            }
        } else {
            return redirect()->to('/login')->with('error', 'Utente non trovato');
        }
    }

    public function logout()
    {
        session()->destroy();
        return redirect()->to('/login');
    }
}
