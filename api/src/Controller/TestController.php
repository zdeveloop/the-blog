<?php


namespace App\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/test", name="test")
 */
class TestController extends AbstractController
{
    /**
     * @Route("", name="")
     * @param Request $request
     * @return Response
     */
    public function test(Request $request):Response
    {
        $response = new JsonResponse(null);
        $name = $request->query->get('name', 'Yorik');
        $data = '{"app": "videon", "version": "1.0", "name": "' . $name . '"}';

        return $response->setJson($data);
    }
}