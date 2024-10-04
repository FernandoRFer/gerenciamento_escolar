import 'package:gerenciamento_escolar/model/course_model.dart';
import 'package:gerenciamento_escolar/model/enrollment_model.dart';
import 'package:gerenciamento_escolar/model/student_model.dart';

final listCourseModel = <CourseModel>[
  CourseModel(
      id: 1,
      description: "Administração",
      syllabus:
          "Administração é a área que maneja recursos financeiros e humanos para alcançar os objetivos de uma organização. A área vem do latim \"administratio\" (direção, gestão) e lida com o gerenciamento de ativos para o sucesso de empresas."),
  CourseModel(
      id: 2,
      description: "Análise e Desenvolvimento de Sistemas",
      syllabus:
          "nálise e Desenvolvimento de Sistemas é a área da tecnologia responsável pela criação, implementação e manutenção de sistemas de software. O profissional da área analisa necessidades de usuários, desenvolve soluções tecnológicas e implementa sistemas que automatizam processos em empresas e organizações."),
  CourseModel(
      id: 3,
      description: "Logística",
      syllabus:
          "Logística é o processo que coordena as etapas necessárias para que um produto ou serviço chegue até o consumidor final. Isso inclui o planejamento, transporte, armazenagem, e distribuição. Ela visa otimizar processos, reduzir custos e aumentar a eficiência nas operações empresariais."),
  CourseModel(
      id: 4,
      description: "Fisioterapia",
      syllabus:
          "A Fisioterapia é a área da saúde que trata disfunções e lesões do movimento humano, reabilitando pacientes afligidos por distúrbios musculoesqueléticos. O objetivo é promover a saúde e bem-estar da população."),
];

final listEnrollment = <EnrollmentModel>[
  EnrollmentModel(
      id: 5,
      student: StudentModel(id: 2, name: " "),
      course: CourseModel(id: 1, description: '', syllabus: '')),
  EnrollmentModel(
      id: 5,
      student: StudentModel(id: 3, name: " "),
      course: CourseModel(id: 1, description: '', syllabus: '')),
  EnrollmentModel(
      id: 1,
      student: StudentModel(id: 1, name: "Fernando Rodrigues Fernandes"),
      course: CourseModel(
          id: 1,
          description: "Curso Docker",
          syllabus: "Curso docke para criar de container")),
  EnrollmentModel(
      id: 2,
      student: StudentModel(id: 1, name: "Fernando Rodrigues Fernandes"),
      course: CourseModel(
          id: 2,
          description: "Curso Docker",
          syllabus: "Curso docke para criar de container")),
  EnrollmentModel(
      id: 3,
      student: StudentModel(id: 1, name: "Fernando Rodrigues Fernandes"),
      course: CourseModel(
          id: 3,
          description: "Curso Docker",
          syllabus: "Curso docke para criar de container")),
  EnrollmentModel(
      id: 4,
      student: StudentModel(id: 1, name: "Fernando Rodrigues Fernandes"),
      course: CourseModel(
          id: 4,
          description: "Curso Docker",
          syllabus: "Curso docke para criar de container"))
];

final listStudents = <StudentModel>[
  StudentModel(
    id: 1,
    name: "Fernando Rodrigues",
  ),
  StudentModel(
    id: 2,
    name: "Carlos Alberto",
  ),
  StudentModel(
    id: 3,
    name: "Maria Fernando",
  ),
  StudentModel(
    id: 4,
    name: "Natalia Dastons",
  ),
];
