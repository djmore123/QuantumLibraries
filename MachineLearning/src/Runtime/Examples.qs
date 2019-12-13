namespace Microsoft.Quantum.MachineLearning {
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;

    operation IrisTrainingData() : LabeledSample[] {
        return [LabeledSample(([0.581557, 0.562824, 0.447721, 0.380219], 1)),
                LabeledSample(([0.570241, 0.544165, 0.503041, 0.354484],
                1)), LabeledSample(([0.510784, 0.475476, 0.453884, 0.554087],
                0)), LabeledSample(([0.492527, 0.473762, 0.471326, 0.557511],
                0)), LabeledSample(([0.543273, 0.501972, 0.518341, 0.429186],
                0)), LabeledSample(([0.520013, 0.485702, 0.440061, 0.547747],
                0)), LabeledSample(([0.585261, 0.545431, 0.462126, 0.382641],
                1)), LabeledSample(([0.541059, 0.479438, 0.568697, 0.392401],
                0)), LabeledSample(([0.555604, 0.517196, 0.474722, 0.445479],
                1)), LabeledSample(([0.592542, 0.537541, 0.468725, 0.374486],
                1)), LabeledSample(([0.552254, 0.51027, 0.511855, 0.415505],
                0)), LabeledSample(([0.530874, 0.465606, 0.503344, 0.498025],
                0)), LabeledSample(([0.568502, 0.492452, 0.524331, 0.399215],
                0)), LabeledSample(([0.511768, 0.53197, 0.46875, 0.485156],
                0)), LabeledSample(([0.555756, 0.420141, 0.553663, 0.456152],
                0)), LabeledSample(([0.584546, 0.562276, 0.439516, 0.385976],
                1)), LabeledSample(([0.608485, 0.577022, 0.427781, 0.337336],
                1)), LabeledSample(([0.546234, 0.59768, 0.46082, 0.36339],
                1)), LabeledSample(([0.596632, 0.510739, 0.482188, 0.388162],
                1)), LabeledSample(([0.512997, 0.525043, 0.460839, 0.49879],
                0)), LabeledSample(([0.477408, 0.488846, 0.465015, 0.562914],
                0)), LabeledSample(([0.553381, 0.457028, 0.546788, 0.431182],
                0)), LabeledSample(([0.543981, 0.555533, 0.491698, 0.392047],
                1)), LabeledSample(([0.532066, 0.497762, 0.5178, 0.448354],
                1)), LabeledSample(([0.505981, 0.460209, 0.506897, 0.524639],
                0)), LabeledSample(([0.44959, 0.489591, 0.490236, 0.563772],
                0)), LabeledSample(([0.498647, 0.482584, 0.502011, 0.516187],
                0)), LabeledSample(([0.552142, 0.553439, 0.474121, 0.405035],
                1)), LabeledSample(([0.495714, 0.452003, 0.497858, 0.549635],
                0)), LabeledSample(([0.523342, 0.480002, 0.484639, 0.510722],
                0)), LabeledSample(([0.493365, 0.473391, 0.504036, 0.527673],
                0)), LabeledSample(([0.552146, 0.542635, 0.505733, 0.380679],
                1)), LabeledSample(([0.578287, 0.517882, 0.46856, 0.421704],
                1)), LabeledSample(([0.588389, 0.569435, 0.47621, 0.320571],
                1)), LabeledSample(([0.572852, 0.583312, 0.441711, 0.369431],
                1)), LabeledSample(([0.540173, 0.571013, 0.440259, 0.43397],
                1)), LabeledSample(([0.588118, 0.554021, 0.452409, 0.377498],
                1)), LabeledSample(([0.499325, 0.454156, 0.500229, 0.542391],
                0)), LabeledSample(([0.541172, 0.446455, 0.491748, 0.515746],
                0)), LabeledSample(([0.501365, 0.513378, 0.488352, 0.496577],
                0)), LabeledSample(([0.519525, 0.498491, 0.475854, 0.505137],
                0)), LabeledSample(([0.549086, 0.561405, 0.474075, 0.398223],
                1)), LabeledSample(([0.504199, 0.486123, 0.476877, 0.53109],
                0)), LabeledSample(([0.530715, 0.466196, 0.504931, 0.496032],
                0)), LabeledSample(([0.515663, 0.527232, 0.474253, 0.480835],
                0)), LabeledSample(([0.498647, 0.482584, 0.502011, 0.516187],
                0)), LabeledSample(([0.591455, 0.54028, 0.471969, 0.368136],
                1)), LabeledSample(([0.459772, 0.46144, 0.462874, 0.601191],
                0)), LabeledSample(([0.527031, 0.492257, 0.472236, 0.506867],
                0)), LabeledSample(([0.534498, 0.534498, 0.495766, 0.427598],
                0)), LabeledSample(([0.561849, 0.441966, 0.530269, 0.455857],
                0)), LabeledSample(([0.483984, 0.503088, 0.458885, 0.549624],
                0)), LabeledSample(([0.525126, 0.566848, 0.450923, 0.446761],
                1)), LabeledSample(([0.576674, 0.501348, 0.480182, 0.430723],
                1)), LabeledSample(([0.58787, 0.558697, 0.451917, 0.371534],
                1)), LabeledSample(([0.584716, 0.552543, 0.446305, 0.391937],
                1)), LabeledSample(([0.604866, 0.502993, 0.484769, 0.382275],
                1)), LabeledSample(([0.576834, 0.538774, 0.469003, 0.39626],
                1)), LabeledSample(([0.588747, 0.563029, 0.444888, 0.372089],
                1)), LabeledSample(([0.575899, 0.560012, 0.4573, 0.38158],
                1)), LabeledSample(([0.552402, 0.574207, 0.444699, 0.409123],
                1)), LabeledSample(([0.589006, 0.546658, 0.46965, 0.365605],
                1)), LabeledSample(([0.540387, 0.443462, 0.537296, 0.471843],
                0)), LabeledSample(([0.570654, 0.548912, 0.458326, 0.403716],
                1)), LabeledSample(([0.544644, 0.547271, 0.467682, 0.430268],
                1)), LabeledSample(([0.525228, 0.503964, 0.508832, 0.459615],
                0)), LabeledSample(([0.462827, 0.527655, 0.461528, 0.542553],
                0)), LabeledSample(([0.50897, 0.522189, 0.507054, 0.459527],
                0)), LabeledSample(([0.546369, 0.577899, 0.460934, 0.393768],
                1)), LabeledSample(([0.615382, 0.467063, 0.492079, 0.401268],
                1)), LabeledSample(([0.573572, 0.473185, 0.510765, 0.431544],
                1)), LabeledSample(([0.510624, 0.60155, 0.43847, 0.430285],
                1)), LabeledSample(([0.563956, 0.532924, 0.469591, 0.421223],
                1)), LabeledSample(([0.581565, 0.592669, 0.391677, 0.396376],
                1)), LabeledSample(([0.533848, 0.501219, 0.4732, 0.489762],
                0)), LabeledSample(([0.530036, 0.577194, 0.452731, 0.425375],
                1)), LabeledSample(([0.595573, 0.439349, 0.494919, 0.455325],
                1)), LabeledSample(([0.584424, 0.557699, 0.438769, 0.393576],
                1)), LabeledSample(([0.544759, 0.441244, 0.494108, 0.514196],
                0)), LabeledSample(([0.552072, 0.545641, 0.487013, 0.400388], 1))
        ];
    }

    operation Examples () : Unit
    {

    }
}
